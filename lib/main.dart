import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/di/injection.dart';
import 'core/theme/app_themes.dart';
import 'data/models/photo_model.dart';
import 'presentation/cubits/photos_cubit.dart';
import 'presentation/cubits/theme_cubit.dart';
import 'presentation/cubits/connectivity_cubit.dart';
import 'presentation/pages/photo_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(PhotoModelAdapter());
  Hive.registerAdapter(PhotoSrcModelAdapter());
  
  // Configure dependencies
  await configureDependencies();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<PhotosCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<ThemeCubit>()..loadSavedTheme(),
        ),
        BlocProvider(
          create: (context) => getIt<ConnectivityCubit>(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            title: 'Photo Gallery',
            debugShowCheckedModeBanner: false,
            theme: AppThemes.lightTheme,
            darkTheme: AppThemes.darkTheme,
            themeMode: themeState.themeMode,
            home: const PhotoListPage(),
          );
        },
      ),
    );
  }
}