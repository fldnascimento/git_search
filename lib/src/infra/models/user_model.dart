import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required int id,
    required String login,
    required String avatarUrl,
    String? company,
    String? location,
    String? bio,
    int? followers,
    int? following,
    int? publicRepos,
  }) : super(
          id: id,
          login: login,
          avatarUrl: avatarUrl,
          company: company,
          location: location,
          bio: bio,
          followers: followers,
          following: following,
          publicRepos: publicRepos,
        );

  static UserModel fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      login: map['login'],
      avatarUrl: map['avatar_url'],
      company: map['company'],
      location: map['location'],
      bio: map['bio'],
      followers: map['followers'],
      following: map['following'],
      publicRepos: map['public_repos'],
    );
  }
}
