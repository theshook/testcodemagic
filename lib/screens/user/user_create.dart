import 'package:flutter/material.dart';
import 'package:test_flutter/models/user.dart';
import 'package:test_flutter/screens/user/user_form.dart';

class CreateUserScreen extends StatefulWidget {
  final Function(User) updateParentState;
  final Function(User) updateUserState;
  final User user;
  const CreateUserScreen({Key key, this.updateParentState, this.user, this.updateUserState})
      : super(key: key);
  @override
  _CreateUserScreenState createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  @override
  Widget build(BuildContext context) {
    String title() {
      if (widget.user == null) return 'Create new user';

      return 'Edit user';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title()),
      ),
      body: UserForm(
        updateParentState: widget.updateParentState,
        updateUserState: widget.updateUserState,
        user: widget.user
      ),
    );
  }
}
