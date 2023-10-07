import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    String message;
    Tokens tokens;
    Data data;

    UserModel({
        required this.message,
        required this.tokens,
        required this.data,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        message: json["message"],
        tokens: Tokens.fromJson(json["tokens"]),
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "tokens": tokens.toJson(),
        "data": data.toJson(),
    };
}

class Data {
    int id;
    String firstName;
    String lastName;
    String email;
    String phoneNumber;
    String username;
    String password;
    String userType;
    dynamic profilePicture;
    bool isPremium;

    Data({
        required this.id,
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.phoneNumber,
        required this.username,
        required this.password,
        required this.userType,
        required this.profilePicture,
        required this.isPremium,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        username: json["username"],
        password: json["password"],
        userType: json["user_type"],
        profilePicture: json["profile_picture"],
        isPremium: json["is_premium"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone_number": phoneNumber,
        "username": username,
        "password": password,
        "user_type": userType,
        "profile_picture": profilePicture,
        "is_premium": isPremium,
    };
}

class Tokens {
    String accessToken;
    String refreshToken;

    Tokens({
        required this.accessToken,
        required this.refreshToken,
    });

    factory Tokens.fromJson(Map<String, dynamic> json) => Tokens(
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
    );

    Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "refresh_token": refreshToken,
    };
}
