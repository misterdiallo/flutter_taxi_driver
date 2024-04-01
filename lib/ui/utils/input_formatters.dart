class InputFormatters {
  static RegExp get emailRegex => RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  static RegExp get latlgRegex => RegExp(r'^((\-?|\+?)?\d+(\.\d+)?)$');

  static RegExp get urlRegex =>
      RegExp(r'^(https?://)?[\da-z\.-]+\.[a-z\.]{2,6}[/\w\.-]*$');
  static RegExp get phoneNumberRegex =>
      RegExp(r'^\+?\d{0,2}\s?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$');
  static RegExp get dateOfBirthRegex => RegExp(r'^\d{4}/\d{2}/\d{2}$');

  static bool isTextEmptyOrNull(text) {
    if (text == null || text.toString().isEmpty) {
      return true;
    }
    return false;
  }
}
