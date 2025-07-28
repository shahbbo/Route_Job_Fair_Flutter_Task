// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../data/datasources/photos_local_data_source.dart' as _i193;
import '../../data/datasources/photos_remote_data_source.dart' as _i807;
import '../../data/repositories/photos_repository_impl.dart' as _i904;
import '../../domain/repositories/photos_repository.dart' as _i285;
import '../../domain/usecases/get_photos_usecase.dart' as _i997;
import '../../presentation/cubits/connectivity_cubit.dart' as _i49;
import '../../presentation/cubits/photos_cubit.dart' as _i794;
import '../../presentation/cubits/theme_cubit.dart' as _i609;
import 'app_module.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => appModule.prefs,
      preResolve: true,
    );
    gh.factory<_i361.Dio>(() => appModule.dio);
    gh.factory<_i895.Connectivity>(() => appModule.connectivity);
    gh.factory<_i609.ThemeCubit>(
        () => _i609.ThemeCubit(gh<_i460.SharedPreferences>()));
    gh.factory<_i193.PhotosLocalDataSource>(
        () => _i193.PhotosLocalDataSourceImpl());
    gh.factory<_i807.PhotosRemoteDataSource>(
        () => _i807.PhotosRemoteDataSource(gh<_i361.Dio>()));
    gh.factory<_i49.ConnectivityCubit>(
        () => _i49.ConnectivityCubit(gh<_i895.Connectivity>()));
    gh.factory<_i285.PhotosRepository>(() => _i904.PhotosRepositoryImpl(
          gh<_i807.PhotosRemoteDataSource>(),
          gh<_i193.PhotosLocalDataSource>(),
          gh<_i895.Connectivity>(),
        ));
    gh.factory<_i997.GetPhotosUseCase>(
        () => _i997.GetPhotosUseCase(gh<_i285.PhotosRepository>()));
    gh.factory<_i794.PhotosCubit>(
        () => _i794.PhotosCubit(gh<_i997.GetPhotosUseCase>()));
    return this;
  }
}

class _$AppModule extends _i460.AppModule {}
