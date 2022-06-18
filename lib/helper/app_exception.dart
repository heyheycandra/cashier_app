class AppException implements Exception {
  final dynamic _message;
  final dynamic _prefix;

  AppException([this._message, this._prefix]);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message]) : super(message, "Error During Communication: ");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class RefreshTokenFailedException extends AppException {
  RefreshTokenFailedException([message]) : super(message, "Refresh Token Failed: ");
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}

class InvalidSessionExpression extends AppException {
  InvalidSessionExpression([message]) : super(message, "Invalid Session: ");
}
