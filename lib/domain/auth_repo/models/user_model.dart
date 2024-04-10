final class UserModel {
  final String? uid;
  final String? email;
  final String? refreshToken;

  UserModel({
    required this.uid,
    required this.email,
    required this.refreshToken,
  });

  Map<String, dynamic> toMap() => <String, dynamic>{
        'uid': uid,
        'email': email,
        'refreshToken': refreshToken,
      };
}
