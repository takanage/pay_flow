import 'dart:convert';

class UserModel {
  final String name;
  final String? photoURl;

  UserModel({required this.name, required this.photoURl});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(name: map['name'], photoURl: map['photoURl']);
  }

  factory UserModel.fromJson(String json) =>
      UserModel.fromMap(jsonDecode(json));

  Map<String, dynamic> toMap() => {
        "name": name,
        "photoURl": photoURl,
      };

  String toJason() => jsonEncode(toMap());
}
