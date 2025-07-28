import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../constants/app_constants.dart';

@module
abstract class AppModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  Dio get dio {
    final dio = Dio();
    dio.options = BaseOptions(
      baseUrl: AppConstants.pexelsBaseUrl,
      headers: {'Authorization': AppConstants.pexelsApiKey},
    );
    return dio;
  }

  Connectivity get connectivity => Connectivity();
}
