import '../../domain/entities/repo_entity.dart';
import 'user_model.dart';

class RepoModel extends RepoEntity {
  RepoModel({
    required int id,
    required String name,
    required int stargazersCount,
    required bool fork,
    required UserModel owner,
    String? description,
    String? language,
  }) : super(
          fork: fork,
          id: id,
          name: name,
          owner: owner,
          stargazersCount: stargazersCount,
          description: description,
          language: language,
        );

  static RepoModel fromMap(Map<String, dynamic> map) {
    return RepoModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      stargazersCount: map['stargazers_count'],
      fork: map['fork'],
      owner: UserModel.fromMap(map['owner']),
      language: map['language'],
    );
  }
}
