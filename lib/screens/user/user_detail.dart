import 'package:flutter/material.dart';
import 'package:test_flutter/models/user.dart';

class UserDetails extends StatelessWidget {
  final User user;

  const UserDetails({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Name: ${user.name}'),
        Text('Username: ${user.username}'),
        Text('Email: ${user.email}'),
      ],
    );
  }
}
