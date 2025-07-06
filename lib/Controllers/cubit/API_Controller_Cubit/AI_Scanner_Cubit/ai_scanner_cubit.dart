import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:ecowin/api/Services/AI_Scanner_Services/ai_scanner_service.dart';
import 'package:equatable/equatable.dart';

part 'ai_scanner_state.dart';

class ScannerCubit extends Cubit<ScannerState> {
  ScannerCubit() : super(ScannerInitial());

  Future<void> sendImageToAPI(String filePath) async {
    emit(ScannerLoading());

    try {
      final result = await ScannerService.detectMaterial(File(filePath));
      emit(ScannerSuccess(result));
    } catch (e) {
      print("Error: $e");
      emit(ScannerError("Detection failed"));
    }
  }
}
