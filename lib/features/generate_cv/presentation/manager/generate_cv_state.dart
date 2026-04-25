import 'dart:typed_data';

abstract class GenerateCvState {}

class GenerateCvInitial extends GenerateCvState {}

class GenerateCvLookupsLoading extends GenerateCvState {}

class GenerateCvLookupsReady extends GenerateCvState {}

class GenerateCvLookupsError extends GenerateCvState {
  final String message;
  GenerateCvLookupsError(this.message);
}

class GenerateCvLoading extends GenerateCvState {}

class GenerateCvSuccess extends GenerateCvState {
  final Uint8List pdfBytes;
  GenerateCvSuccess(this.pdfBytes);
}

class GenerateCvError extends GenerateCvState {
  final String message;
  GenerateCvError(this.message);
}
