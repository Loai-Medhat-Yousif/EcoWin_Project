part of 'ai_scanner_cubit.dart';

abstract class ScannerState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ScannerInitial extends ScannerState {}

class ScannerLoading extends ScannerState {}

class ScannerSuccess extends ScannerState {
  final String materialName;
  ScannerSuccess(this.materialName);

  @override
  List<Object?> get props => [materialName];
}

class ScannerError extends ScannerState {
  final String message;
  ScannerError(this.message);

  @override
  List<Object?> get props => [message];
}
