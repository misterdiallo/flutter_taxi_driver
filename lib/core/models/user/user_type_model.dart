enum UserType {
  driver,
  customer,
  admin,
}

UserType userTypeFromString(String value) {
  return UserType.values.firstWhere(
      (type) => type.toString().split('.').last == value.toLowerCase());
}

extension UserTypeExtension on UserType {
  String toMap() {
    return toString().split('.').last;
  }

  static UserType fromMap(String value) {
    switch (value) {
      case 'driver':
        return UserType.driver;
      case 'customer':
        return UserType.customer;
      case 'admin':
        return UserType.admin;
      default:
        throw ArgumentError('Invalid UserType value: $value');
    }
  }
}
