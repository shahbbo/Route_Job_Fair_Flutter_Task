import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../core/error/failures.dart';
import '../../domain/repositories/photos_repository.dart';
import '../models/photo_model.dart';
import '../datasources/photos_remote_data_source.dart';
import '../datasources/photos_local_data_source.dart';

@Injectable(as: PhotosRepository)
class PhotosRepositoryImpl implements PhotosRepository {
  final PhotosRemoteDataSource _remoteDataSource;
  final PhotosLocalDataSource _localDataSource;
  final Connectivity _connectivity;

  PhotosRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
    this._connectivity,
  );

  @override
  Future<Either<Failure, PhotosResponseModel>> getCuratedPhotos({
    required int page,
    required int perPage,
  }) async {
    try {
      final connectivityResult = await _connectivity.checkConnectivity();
      final isConnected = connectivityResult != ConnectivityResult.none;

      if (isConnected) {
        try {
          final remotePhotos = await _remoteDataSource.getCuratedPhotos(
            page: page,
            perPage: perPage,
          );

          if (page == 1) {
            await _localDataSource.cachePhotos(remotePhotos.photos);
          }

          return Right(remotePhotos);
        } catch (e) {
          if (page == 1) {
            return _getLocalPhotos();
          }
          return Left(ServerFailure('Failed to fetch photos: $e'));
        }
      } else {
        if (page == 1) {
          return _getLocalPhotos();
        }
        return const Left(NetworkFailure('No internet connection'));
      }
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  Future<Either<Failure, PhotosResponseModel>> _getLocalPhotos() async {
    try {
      final cachedPhotos = await _localDataSource.getCachedPhotos();
      return Right(PhotosResponseModel(
        page: 1,
        perPage: cachedPhotos.length,
        photos: cachedPhotos,
        totalResults: cachedPhotos.length,
        nextPage: null,
      ));
    } catch (e) {
      return Left(CacheFailure('Failed to get cached photos: $e'));
    }
  }
}
