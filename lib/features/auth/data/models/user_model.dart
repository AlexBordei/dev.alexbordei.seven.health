import 'package:sevenhealth/features/auth/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required String id,
    required String name,
    required String email,
    String? photoUrl,
  }) : super(
          id: id,
          name: name,
          email: email,
          photoUrl: photoUrl,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      photoUrl: json['photo_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'photo_url': photoUrl,
    };
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      name: user.name,
      email: user.email,
      photoUrl: user.photoUrl,
    );
  }
}
