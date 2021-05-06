import 'package:social_app/models/address.dart';

class User{
  int id;
  String name;
  String username;
  String email;
  Address adress;
  String phone;
  String website;

  User.fromJson(Map<String, dynamic> json):
        id = json['int'],
        name = json['name'],
        username = json['username'],
        email = json['email'],
        adress = Address.fromJson(json['address']),
        phone = json['phone'],
        website = json['website'];


}