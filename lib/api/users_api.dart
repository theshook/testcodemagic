import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test_flutter/api/api.dart';
import 'package:test_flutter/models/user.dart';

class UsersApi {
  Future<List<User>> getUsersData() async {
    http.Response usersJson = await http.get('${ApiCollection.url}/users');

    if (usersJson.statusCode != 200) throw "Can't fetch users data";

    List<User> users = (jsonDecode(usersJson.body) as List)
        .map((user) => User.fromJson(user))
        .toList();
    return users;
  }

  Future<User> createUserData(User user) async {
    http.Response usersJson = await http.post(
      '${ApiCollection.url}/users',
      body: user.toJson(),
    );

    if (usersJson.statusCode != 201) throw "Can't create user data";

    return User.fromJson(jsonDecode(usersJson.body));
  }

  Future<void> removeUserData(int id) async {
    http.Response response =
        await http.delete('${ApiCollection.url}/users/$id');

    if (response.statusCode != 200) throw "Can't remove user data";
  }

  Future<User> updateUserData(User user) async {
    http.Response response = await http
        .put('${ApiCollection.url}/users/${user.id}', body: user.toJson());

    if (response.statusCode != 200) throw "Can't update user data";

    return User.fromJson(jsonDecode(response.body));
  }
}
