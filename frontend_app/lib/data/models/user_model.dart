import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String accessToken;
  Data data;

  UserModel({
    required this.accessToken,
    required this.data,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        accessToken: json["access_token"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "data": data.toJson(),
      };
}

class Data {
  int id;
  String password;
  DateTime lastLogin;
  bool isSuperuser;
  String username;
  String firstName;
  String lastName;
  String email;
  bool isStaff;
  bool isActive;
  DateTime dateJoined;
  dynamic phoneNumber;
  String userType;
  dynamic profilePicture;
  bool isPremium;
  List<dynamic> groups;
  List<dynamic> userPermissions;

  Data({
    required this.id,
    required this.password,
    required this.lastLogin,
    required this.isSuperuser,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.isStaff,
    required this.isActive,
    required this.dateJoined,
    required this.phoneNumber,
    required this.userType,
    required this.profilePicture,
    required this.isPremium,
    required this.groups,
    required this.userPermissions,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        password: json["password"],
        lastLogin: DateTime.parse(json["last_login"]),
        isSuperuser: json["is_superuser"],
        username: json["username"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        isStaff: json["is_staff"],
        isActive: json["is_active"],
        dateJoined: DateTime.parse(json["date_joined"]),
        phoneNumber: json["phone_number"],
        userType: json["user_type"],
        profilePicture: json["profile_picture"],
        isPremium: json["is_premium"],
        groups: List<dynamic>.from(json["groups"].map((x) => x)),
        userPermissions:
            List<dynamic>.from(json["user_permissions"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "password": password,
        "last_login": lastLogin.toIso8601String(),
        "is_superuser": isSuperuser,
        "username": username,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "is_staff": isStaff,
        "is_active": isActive,
        "date_joined": dateJoined.toIso8601String(),
        "phone_number": phoneNumber,
        "user_type": userType,
        "profile_picture": profilePicture,
        "is_premium": isPremium,
        "groups": List<dynamic>.from(groups.map((x) => x)),
        "user_permissions": List<dynamic>.from(userPermissions.map((x) => x)),
      };
}
