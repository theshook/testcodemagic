import 'package:flutter/material.dart';
import 'package:test_flutter/models/user.dart';
import 'package:test_flutter/screens/user/user_create.dart';
import 'package:test_flutter/screens/user/user_detail.dart';

class UserScreen extends StatelessWidget {
  final User user;
  final Function(User) updateUserState;
  const UserScreen({Key key, this.user, this.updateUserState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => CreateUserScreen(
                  user: user,
                  updateUserState: updateUserState,
                ),
              ),
            ),
          )
        ],
      ),
      body: UserDetails(
        user: user,
      ),
    );
  }
}
