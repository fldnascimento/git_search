class UserEntity {
  final int id;
  final String login;
  final String avatarUrl;
  final String? company;
  final String? name;
  final String? location;
  final String? bio;
  final int? followers;
  final int? following;
  final int? publicRepos;

  const UserEntity({
    required this.id,
    required this.login,
    required this.avatarUrl,
    this.company,
    this.name,
    this.location,
    this.bio,
    this.followers,
    this.following,
    this.publicRepos,
  });
}
