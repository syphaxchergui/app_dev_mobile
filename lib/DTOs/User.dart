import 'package:tp_2/DTOs/Activity.dart';

class User {
  final String id;
  final String username;
  String password;
  String address;
  DateTime birthday;
  String postalCode;
  String city;
  List<Activity> cart;

  User({
    required this.id,
    required this.username,
    required this.password,
    required this.address,
    required this.birthday,
    required this.postalCode,
    required this.city,
    this.cart = const [],
  });
}
