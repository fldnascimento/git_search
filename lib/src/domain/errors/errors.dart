class Error implements Exception {}

class UsersNotFound extends Error {}

class UserNotFound extends Error {}

class ReposNotFound extends Error {}

class RateLimitExceeded extends Error {}

class TimeoutConnection extends Error {}

class ParamEmpty extends Error {}
