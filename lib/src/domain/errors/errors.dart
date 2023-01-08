class Error implements Exception {
  final String? errorMessage;
  const Error({this.errorMessage});
}

class UsersNotFound extends Error {
  const UsersNotFound() : super(errorMessage: 'Nenhum usuário encontrado');
}

class UserNotFound extends Error {}

class ReposNotFound extends Error {
  const ReposNotFound() : super(errorMessage: 'Nenhum repositório encontrado');
}

class RateLimitExceeded extends Error {}

class TimeoutConnection extends Error {}

class ParamEmpty extends Error {}
