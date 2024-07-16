class LoggedUser {
  LoggedUser._privateConstructor();

  static final LoggedUser _shared = LoggedUser._privateConstructor();

  static LoggedUser get instance => _shared;

  String name = "";
  String email = "";
}
