import 'dart:typed_data';

abstract class GenerateCvState {}

class GenerateCvInitial extends GenerateCvState {}

class GenerateCvLoading extends GenerateCvState {}

class GenerateCvSuccess extends GenerateCvState {
  final Uint8List pdfBytes;
  GenerateCvSuccess(this.pdfBytes);
}

class GenerateCvError extends GenerateCvState {
  final String message;
  GenerateCvError(this.message);
}