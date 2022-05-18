//User Model
class UserModel {
  final String uid;
  final String email;
  final String name;
  final String photoUrl;
  final String status;
  final int state;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.photoUrl,
    required this.status,
    required this.state,
  });

  factory UserModel.fromMap(Map data) {
    return UserModel(
      status: data['status'] ?? '',
      state: data['state'] ?? '',
      uid: data['uid'],
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      photoUrl: data['photoUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() =>
      {"uid": uid, "email": email, "name": name, "photoUrl": photoUrl, 'status': status, 'state': state};
}
