class User {
  final String id;
  final String username;
  String address;
  DateTime birthday;
  String postalCode;
  String city;

  User({
    required this.id,
    required this.username,
    required this.address,
    required this.birthday,
    required this.postalCode,
    required this.city,
  });
}
