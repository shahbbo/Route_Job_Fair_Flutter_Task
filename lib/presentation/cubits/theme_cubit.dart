import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/app_constants.dart';

@injectable
class ThemeCubit extends Cubit<ThemeState> {
  final SharedPreferences _prefs;

  ThemeCubit(this._prefs) : super(const ThemeState(ThemeMode.system));

  Future<void> loadSavedTheme() async {
    final themeIndex = _prefs.getInt(AppConstants.themeKey) ?? 0;
    final themeMode = ThemeMode.values[themeIndex];
    emit(ThemeState(themeMode));
  }

  Future<void> toggleTheme() async {
    final newThemeMode =
        state.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;

    await _prefs.setInt(AppConstants.themeKey, newThemeMode.index);
    emit(ThemeState(newThemeMode));
  }

  Future<void> setTheme(ThemeMode themeMode) async {
    await _prefs.setInt(AppConstants.themeKey, themeMode.index);
    emit(ThemeState(themeMode));
  }
}

class ThemeState {
  final ThemeMode themeMode;

  const ThemeState(this.themeMode);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ThemeState && other.themeMode == themeMode;
  }

  @override
  int get hashCode => themeMode.hashCode;
}
