String formatCertificateDate(DateTime? value) {
  if (value == null) return 'Unknown date';
  final month = value.month.toString().padLeft(2, '0');
  final day = value.day.toString().padLeft(2, '0');
  return '${value.year}-$month-$day';
}
