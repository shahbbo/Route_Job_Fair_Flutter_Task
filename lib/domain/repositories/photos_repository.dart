import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../../data/models/photo_model.dart';

abstract class PhotosRepository {
  Future<Either<Failure, PhotosResponseModel>> getCuratedPhotos({
    required int page,
    required int perPage,
  });
}
