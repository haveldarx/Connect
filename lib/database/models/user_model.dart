class UserModel {
  final String defaultAddressId;
  final String defaultVehicleId;
  final String email;
  final String name;
  final String phone;
  final String profileImageUrl;
  final String id;
  final DateTime timestamp;

// UserModel constructor to initalize all the fields.
  UserModel({
    required this.defaultAddressId,
    required this.defaultVehicleId,
    required this.email,
    required this.name,
    required this.phone,
    required this.profileImageUrl,
    required this.id,
    required this.timestamp,
  });}