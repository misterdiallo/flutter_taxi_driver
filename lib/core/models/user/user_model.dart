// ignore_for_file: non_constant_identifier_names

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
  final String user_id;
  final String full_name;
  final String email;
  final String phone_number;
  final UserType user_type;
  final String? address;
  final DateTime? date_of_birth;
  final bool is_active;

  UserModel({
    required this.user_id,
    required this.full_name,
    required this.email,
    required this.phone_number,
    required this.user_type,
    this.address,
    this.date_of_birth,
    this.is_active = false,
  });

  UserModel copyWith({
    String? userId,
    String? fullName,
    String? email,
    String? phoneNumber,
    UserType? userType,
    String? address,
    DateTime? dateOfBirth,
    bool? isActive,
  }) {
    return UserModel(
      user_id: userId ?? user_id,
      full_name: fullName ?? full_name,
      email: email ?? this.email,
      phone_number: phoneNumber ?? phone_number,
      user_type: userType ?? user_type,
      address: address ?? this.address,
      date_of_birth: dateOfBirth ?? date_of_birth,
      is_active: isActive ?? is_active,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'userId': user_id});
    result.addAll({'fullName': full_name});
    result.addAll({'email': email});
    result.addAll({'phoneNumber': phone_number});
    result.addAll({'userType': user_type.toMap()});
    if (address != null) {
      result.addAll({'address': address});
    }
    if (date_of_birth != null) {
      result.addAll({'dateOfBirth': date_of_birth!.millisecondsSinceEpoch});
    }
    result.addAll({'isActive': is_active});

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      user_id: map['user_id'] ?? '',
      full_name: map['full_name'] ?? '',
      email: map['email'] ?? '',
      phone_number: map['phone_number'] ?? '',
      user_type: UserTypeExtension.fromMap(map['user_type']),
      address: map['address'],
      date_of_birth: map['date_of_birth'] != null
          ? DateTime.parse(map['date_of_birth'])
          : null,
      is_active: map['is_active'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(userId: $user_id, fullName: $full_name, email: $email, phoneNumber: $phone_number, userType: $user_type, address: $address, dateOfBirth: $date_of_birth, isActive: $is_active)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.user_id == user_id &&
        other.full_name == full_name &&
        other.email == email &&
        other.phone_number == phone_number &&
        other.user_type == user_type &&
        other.address == address &&
        other.date_of_birth == date_of_birth &&
        other.is_active == is_active;
  }

  @override
  int get hashCode {
    return user_id.hashCode ^
        full_name.hashCode ^
        email.hashCode ^
        phone_number.hashCode ^
        user_type.hashCode ^
        address.hashCode ^
        date_of_birth.hashCode ^
        is_active.hashCode;
  }
}

extension UserModelExtension on UserModel {
  static UserModel convertLoggedToUserModel(Map<String, dynamic> userData) {
    final userMetadata = userData['user']['user_metadata'];
    UserType userType = UserTypeExtension.fromMap(
        userMetadata['userType'].toString().toLowerCase());

    return UserModel(
      user_id: userData['user']['id'],
      full_name: userMetadata['fullName'],
      email: userMetadata['email'],
      phone_number: userMetadata['phoneNumber'],
      user_type: userType,
      address: userMetadata['address'],
      is_active: userMetadata['isActive'],
      date_of_birth: null,
    );
  }

  static List<UserModel> convertToUserModelList(
      List<Map<String, dynamic>> maps) {
    List<UserModel> users = [];
    for (var map in maps) {
      UserModel user = UserModel(
        user_id: map['user_id'],
        full_name: map['full_name'],
        email: map['email'],
        phone_number: map['phone_number'],
        user_type: UserTypeExtension.fromMap(
            map['user_type'].toString().toLowerCase()),
        address: map['address'],
        date_of_birth: map['date_of_birht'] != null
            ? DateTime.parse(map['date_of_birht'])
            : null,
        is_active: map['is_active'],
      );
      users.add(user);
    }
    return users;
  }
}
