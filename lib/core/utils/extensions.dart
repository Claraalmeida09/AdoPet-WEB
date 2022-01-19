extension StringExtension on String {
  bool get isNullEmptyOrWhitespace => isEmpty || trim().isEmpty;
}
