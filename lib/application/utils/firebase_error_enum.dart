enum FirebaseErrorEnum {
  invalidCredentials,
  userDisabled,
  userNotFound,
  emailAlreadyUsed,
  genericError
}

extension FirebaseErrorMessage on FirebaseErrorEnum {
  String get message {
    switch (this) {
      case FirebaseErrorEnum.invalidCredentials:
        return "Inavalid mail or password.";
      case FirebaseErrorEnum.userDisabled:
        return "User disabled.";
      case FirebaseErrorEnum.userNotFound:
        return "This user does not exists.";
      case FirebaseErrorEnum.emailAlreadyUsed:
        return "This user is already registered.";
      case FirebaseErrorEnum.genericError:
        return "Oops, something went wrong";
    }
  }
}
