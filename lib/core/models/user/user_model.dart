import 'dart:convert';
import 'package:taxi_driver_app/core/models/user/user_type_model.dart';

class CreateUserRequest {
  final String fullName;
  final String email;
  final String phoneNumber;
  final UserType userType;
  final String password;

  CreateUserRequest(this.fullName, this.email, this.phoneNumber, this.userType,
      this.password);
  Map<String, dynamic> toJson() {
    return {
      "fullName": fullName,
      "email": email,
      "phoneNumber": phoneNumber,
      "userType": userType,
      "password": password,
    };
  }
}

class UpdatePasswordRequest {
  String oldPassword;
  String password;
  String userId;
  UpdatePasswordRequest(
    this.userId,
    this.oldPassword,
    this.password,
  );
  Map<String, dynamic> toJson() {
    return {
      "oldPassword": oldPassword,
      "password": password,
      "userId": userId,
    };
  }
}

class LoginUserRequest {
  String login;
  String password;
  LoginUserRequest(
    this.login,
    this.password,
  );
  Map<String, dynamic> toJson() {
    return {
      "login": login,
      "password": password,
    };
  }
}

class LoginUserResponse {
  String token;
  LoginUserResponse(this.token);
  Map<String, dynamic> toJson() {
    return {
      "token": token,
    };
  }
}

class UserModel {
  final String userId;
  final String fullName;
  final String email;
  final String phoneNumber;
  final UserType userType;
  final String? address;
  final DateTime? dateOfBirth;

  UserModel({
    required this.userId,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.userType,
    this.address,
    this.dateOfBirth,
  });

  UserModel copyWith({
    String? userId,
    String? fullName,
    String? email,
    String? phoneNumber,
    UserType? userType,
    String? address,
    DateTime? dateOfBirth,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      userType: userType ?? this.userType,
      address: address ?? this.address,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'userType': userType.toMap(), // Using the toMap method of UserType
      if (address != null) 'address': address,
      if (dateOfBirth != null)
        'dateOfBirth': dateOfBirth!.millisecondsSinceEpoch,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] ?? '',
      fullName: map['fullName'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      userType: UserTypeExtension.fromMap(
          map['userType']), // Using the fromMap method of UserType
      address: map['address'],
      dateOfBirth: map['dateOfBirth'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dateOfBirth'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(userId: $userId, fullName: $fullName, email: $email, phoneNumber: $phoneNumber, userType: $userType, address: $address, dateOfBirth: $dateOfBirth)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.userId == userId &&
        other.fullName == fullName &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.userType == userType &&
        other.address == address &&
        other.dateOfBirth == dateOfBirth;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        fullName.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        userType.hashCode ^
        address.hashCode ^
        dateOfBirth.hashCode;
  }
}
