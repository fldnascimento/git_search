import 'errors_messages.dart';

class Error implements Exception {
  final String message;
  const Error(this.message);
}

class UsersNotFound extends Error {
  const UsersNotFound() : super(ErrorsMessages.usersNotFound);
}

class UserNotFound extends Error {
  const UserNotFound() : super(ErrorsMessages.userNotFound);
}

class ReposNotFound extends Error {
  const ReposNotFound() : super(ErrorsMessages.reposNotFound);
}

class RateLimitExceeded extends Error {
  const RateLimitExceeded() : super(ErrorsMessages.rateLimitExceeded);
}

class TimeoutConnection extends Error {
  const TimeoutConnection() : super(ErrorsMessages.timeoutConnection);
}

class ParamEmpty extends Error {
  const ParamEmpty() : super(ErrorsMessages.paramEmpty);
}

class ErrorUnknown extends Error {
  const ErrorUnknown() : super(ErrorsMessages.errorUnknown);
}
