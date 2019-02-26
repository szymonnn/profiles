import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserProvider {
  Future<List<User>> getUsers() async {
    final response = await http.get('https://randomuser.me/api/?results=100');

    if (response.statusCode == 200) {
      List<User> users = [];
      for (var value in json.decode(response.body)['results']) {
        users.add(User.fromJson(value));
      }
      return users;
    } else {
      throw Exception('Failed to load users');
    }
  }
}

class User {
  final String name;
  final String email;
  final String thumbnailUrl;


  User(this.name, this.email, this.thumbnailUrl);

  factory User.fromJson(Map<String, dynamic> json){
    String firstName = json['name']['first'];
    String lastName = json['name']['last'];
    String email = json['email'];
    String thumbnail = json['picture']['thumbnail'];

    return User('$firstName $lastName', email, thumbnail);
  }
}