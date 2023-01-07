class Error implements Exception {
  final String? errorMessage;
  const Error({this.errorMessage});
}

class UsersNotFound extends Error {
  const UsersNotFound(String errorMessage) : super(errorMessage: errorMessage);
}

class UserNotFound extends Error {}

class ReposNotFound extends Error {}

class RateLimitExceeded extends Error {}

class TimeoutConnection extends Error {}

class ParamEmpty extends Error {}
