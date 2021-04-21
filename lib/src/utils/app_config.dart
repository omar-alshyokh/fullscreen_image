class AppConfig {
  /// just to check string if equal null or empty
  bool notNullOrEmpty(String? value) {
    return value != null && value.isNotEmpty;
  }
}

AppConfig appConfig = AppConfig();
