import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/connectivity_cubit.dart';
import '../../core/constants/app_constants.dart';

class ConnectivityIndicator extends StatelessWidget {
  const ConnectivityIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityCubit, ConnectivityState>(
      builder: (context, state) {
        if (state is ConnectivityIndicator) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: state.isConnected ? 0 : 40,
            child: Container(
              width: double.infinity,
              color: state.isConnected ? Colors.green : Colors.orange,
              child: state.isConnected
                  ? const SizedBox.shrink()
                  : const Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.wifi_off,
                            color: Colors.white,
                            size: 16,
                          ),
                          SizedBox(width: 8),
                          Text(
                            AppStrings.offlineMode,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
