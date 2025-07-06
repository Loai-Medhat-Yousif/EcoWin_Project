import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:ecowin/Controllers/cubit/API_Controller_Cubit/AI_Scanner_Cubit/ai_scanner_cubit.dart';
import 'package:ecowin/Core/Constants/screen_dialogs.dart';
import 'package:ecowin/Core/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScannerView extends StatelessWidget {
  const ScannerView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ScannerCubit(),
      child: BlocConsumer<ScannerCubit, ScannerState>(
        listener: (context, state) {
          if (state is ScannerError) {
            ScreenDialogs.showFailureDialog(
                context, state.message, "Ok", () {});
          }
          if (state is ScannerSuccess) {
            ScreenDialogs.showSuccessDialog(
                context, 'The Material is ${state.materialName}', "OK", () {});
          }
        },
        builder: (context, state) {
          if (state is ScannerLoading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: AppColors.mainColor,
                ),
              ),
            );
          }

          return Scaffold(
            body: CameraAwesomeBuilder.awesome(
              progressIndicator: const Center(
                  child: CircularProgressIndicator(
                color: AppColors.mainColor,
              )),
              saveConfig: SaveConfig.photo(),
              theme: AwesomeTheme(
                bottomActionsBackgroundColor: AppColors.mainColor,
              ),
              bottomActionsBuilder: (state) => AwesomeBottomActions(
                state: state,
                left: AwesomeFlashButton(
                  state: state,
                ),
                right: AwesomeCameraSwitchButton(
                  state: state,
                  scale: 1.0,
                  onSwitchTap: (state) {
                    state.switchCameraSensor(
                      aspectRatio: state.sensorConfig.aspectRatio,
                    );
                  },
                ),
              ),
              topActionsBuilder: (state) {
                return Container(
                  color: AppColors.mainColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      const Spacer(),
                    ],
                  ),
                );
              },
              onMediaCaptureEvent: (event) {
                print(event.status);
                if (event.status == MediaCaptureStatus.success &&
                    event.isPicture) {
                  event.captureRequest.when(
                    single: (single) {
                      context
                          .read<ScannerCubit>()
                          .sendImageToAPI(single.file!.path);
                    },
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
