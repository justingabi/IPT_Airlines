import 'dart:convert';
import 'package:http/http.dart' as http;

class Users {
  final String userId;
  final String email;
  final String password;
  final String firstname;
  final String lastname;

  Users({
    required this.userId,
    required this.email,
    required this.password,
    required this.firstname,
    required this.lastname,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      userId: json['userId'],
      email: json['email'],
      password: json['password'],
      firstname: json['firstname'],
      lastname: json['lastname'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'email': email,
      'password': password,
      'firstname': firstname,
      'lastname': lastname,
    };
  }
}

Future<Users> fetchUsersByEmail(String email) async {
  final response =
      await http.get(Uri.parse('http://127.0.0.1:8000/users/$email'));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final user = Users.fromJson(data);
    return user;
  } else {
    throw Exception('Failed to fetch users');
  }
}

Future<bool> registerUser(String userId, String email, String password,
    String firstName, String lastName) async {
  final url = 'http://127.0.0.1:8000/register/';

  final response = await http.post(
    Uri.parse('http://127.0.0.1:8000/register/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'userId': userId,
      'email': email,
      'password': password,
      'firstname': firstName,
      'lastname': lastName,
    }),
  );

  if (response.statusCode == 201) {
    return true;
  } else {
    return false;
  }
}
