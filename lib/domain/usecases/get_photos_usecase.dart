import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../core/error/failures.dart';
import '../../data/models/photo_model.dart';
import '../repositories/photos_repository.dart';

@injectable
class GetPhotosUseCase {
  final PhotosRepository _repository;

  GetPhotosUseCase(this._repository);

  Future<Either<Failure, PhotosResponseModel>> call({
    required int page,
    required int perPage,
  }) async {
    return await _repository.getCuratedPhotos(
      page: page,
      perPage: perPage,
    );
  }
}
