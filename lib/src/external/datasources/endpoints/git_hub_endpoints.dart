class GitHubEndpoints {
  const GitHubEndpoints();

  static const String _base = 'https://api.github.com';

  static String findUsers(String query) {
    return '$_base/search/users?q=$query';
  }

  static String findRepos(String query) {
    return '$_base/search/repositories?q=$query';
  }

  static String getUser(String login) {
    return '$_base/users/$login';
  }

  static String getReposStarred(String login) {
    return '$_base/users/$login/starred';
  }
}
