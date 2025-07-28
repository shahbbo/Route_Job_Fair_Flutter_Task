import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../models/photo_model.dart';
import '../../core/constants/app_constants.dart';

part 'photos_remote_data_source.g.dart';

@RestApi()
@injectable
abstract class PhotosRemoteDataSource {
  @factoryMethod
  factory PhotosRemoteDataSource(Dio dio) = _PhotosRemoteDataSource;

  @GET(AppConstants.photosEndpoint)
  Future<PhotosResponseModel> getCuratedPhotos({
    @Query('page') int page = 1,
    @Query('per_page') int perPage = AppConstants.defaultPerPage,
  });
}