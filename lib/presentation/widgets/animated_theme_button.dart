import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/theme_cubit.dart';

class AnimatedThemeButton extends StatelessWidget {
  const AnimatedThemeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final isDark = state.themeMode == ThemeMode.dark;

        return GestureDetector(
          onTap: () {
            context.read<ThemeCubit>().toggleTheme();
          },
          child: Container(
            width: 100,
            height: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(23),
              color: isDark ? Colors.grey[850]! : Colors.grey[300]!,
              border: Border.all(
                  color: isDark ? Colors.white : Colors.blue, width: 3),
            ),
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  left: isDark ? 57 : -1,
                  top: -1,
                  child: Container(
                    width: 42,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isDark ? Colors.white : Colors.blue,
                    ),
                  ),
                ),
                Positioned(
                  left: 8,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: Icon(
                      Icons.wb_sunny,
                      color: !isDark ? Colors.white : Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                Positioned(
                  right: 8,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: Icon(
                      Icons.nights_stay,
                      color: isDark ? Colors.black : Colors.blue,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
