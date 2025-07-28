import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../data/models/photo_model.dart';
import '../../domain/usecases/get_photos_usecase.dart';
import '../../core/constants/app_constants.dart';

@injectable
class PhotosCubit extends Cubit<PhotosState> {
  final GetPhotosUseCase _getPhotosUseCase;
  final PagingController<int, PhotoModel> pagingController = 
      PagingController(firstPageKey: 1);

  PhotosCubit(this._getPhotosUseCase) : super(PhotosState.initial()) {
    pagingController.addPageRequestListener(_fetchPage);
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final result = await _getPhotosUseCase.call(
        page: pageKey,
        perPage: AppConstants.defaultPerPage,
      );

      result.fold(
        (failure) {
          pagingController.error = failure.message;
        },
        (photosResponse) {
          final isLastPage = photosResponse.photos.length < AppConstants.defaultPerPage;
          if (isLastPage) {
            pagingController.appendLastPage(photosResponse.photos);
          } else {
            final nextPageKey = pageKey + 1;
            pagingController.appendPage(photosResponse.photos, nextPageKey);
          }
        },
      );
    } catch (error) {
      pagingController.error = error;
    }
  }

  void refreshPhotos() {
    pagingController.refresh();
  }

  @override
  Future<void> close() {
    pagingController.dispose();
    return super.close();
  }
}

class PhotosState {
  const PhotosState();

  factory PhotosState.initial() => const PhotosState();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PhotosState;
  }

  @override
  int get hashCode => 0;
}