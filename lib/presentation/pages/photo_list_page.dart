import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../cubits/photos_cubit.dart';
import '../cubits/connectivity_cubit.dart';
import '../widgets/photo_grid_item.dart';
import '../widgets/animated_theme_button.dart';
import '../widgets/app_logo.dart';
import '../../data/models/photo_model.dart';
import '../../core/constants/app_constants.dart';

class PhotoListPage extends StatelessWidget {
  const PhotoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: AppLogo(),
        ),
        title: const Text(AppStrings.appTitle),
        actions: const [
          AnimatedThemeButton(),
          SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          // Connectivity indicator
          BlocBuilder<ConnectivityCubit, ConnectivityState>(
            builder: (context, state) {
              if (!state.isConnected) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  color: Colors.blue[100],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.wifi_off, color: Colors.red[800]),
                      const SizedBox(width: 8),
                      Text(
                        AppStrings.offlineMode,
                        style: TextStyle(color: Colors.red[800]),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          // Photo grid
          Expanded(
            child: BlocBuilder<PhotosCubit, PhotosState>(
              builder: (context, state) {
                return PagedMasonryGridView<int, PhotoModel>.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  pagingController:
                      context.read<PhotosCubit>().pagingController,
                  padding: const EdgeInsets.all(16),
                  builderDelegate: PagedChildBuilderDelegate<PhotoModel>(
                    itemBuilder: (context, item, index) => PhotoGridItem(
                      photo: item,
                    ),
                    firstPageErrorIndicatorBuilder: (context) => _ErrorWidget(
                      onRetry: () =>
                          context.read<PhotosCubit>().refreshPhotos(),
                    ),
                    newPageErrorIndicatorBuilder: (context) => _ErrorWidget(
                      onRetry: () =>
                          context.read<PhotosCubit>().refreshPhotos(),
                    ),
                    firstPageProgressIndicatorBuilder: (context) =>
                        const _LoadingWidget(),
                    newPageProgressIndicatorBuilder: (context) => const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                    noItemsFoundIndicatorBuilder: (context) => const Center(
                      child: Text('No photos found'),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text(AppStrings.loadingPhotos),
        ],
      ),
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  final VoidCallback onRetry;

  const _ErrorWidget({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red,
          ),
          const SizedBox(height: 16),
          const Text(
            AppStrings.errorLoadingPhotos,
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text(AppStrings.retryButton),
          ),
        ],
      ),
    );
  }
}
