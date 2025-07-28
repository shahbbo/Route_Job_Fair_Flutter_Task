import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import '../models/photo_model.dart';
import '../../core/constants/app_constants.dart';

abstract class PhotosLocalDataSource {
  Future<List<PhotoModel>> getCachedPhotos();
  Future<void> cachePhotos(List<PhotoModel> photos);
  Future<void> clearCache();
}

@Injectable(as: PhotosLocalDataSource)
class PhotosLocalDataSourceImpl implements PhotosLocalDataSource {
  @override
  Future<List<PhotoModel>> getCachedPhotos() async {
    final box = await Hive.openBox<PhotoModel>(AppConstants.hiveBoxName);
    return box.values.toList();
  }

  @override
  Future<void> cachePhotos(List<PhotoModel> photos) async {
    final box = await Hive.openBox<PhotoModel>(AppConstants.hiveBoxName);
    await box.clear(); // Clear old data
    for (int i = 0; i < photos.length; i++) {
      await box.put(i, photos[i]);
    }
  }

  @override
  Future<void> clearCache() async {
    final box = await Hive.openBox<PhotoModel>(AppConstants.hiveBoxName);
    await box.clear();
  }
}