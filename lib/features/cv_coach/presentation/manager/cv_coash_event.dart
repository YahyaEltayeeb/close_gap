import 'dart:io';

sealed class CvCoashEvent {}

class SumbitCvEvent extends CvCoashEvent {
  File file;
  SumbitCvEvent({required this.file});
}
