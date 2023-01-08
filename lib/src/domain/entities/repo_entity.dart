import 'user_entity.dart';

class RepoEntity {
  final int id;
  final String name;
  final String? description;
  final int stargazersCount;
  final bool fork;
  final UserEntity owner;
  final String? language;

  RepoEntity({
    required this.id,
    required this.name,
    required this.stargazersCount,
    required this.fork,
    required this.owner,
    this.description,
    this.language,
  });
}
