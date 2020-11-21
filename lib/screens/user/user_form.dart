import 'package:flutter/material.dart';
import 'package:test_flutter/api/users_api.dart';
import 'package:test_flutter/models/user.dart';
import 'package:test_flutter/widgets/rounded_elevated_button.dart';
import 'package:test_flutter/widgets/rounded_input.dart';

class UserForm extends StatefulWidget {
  final Function(User) updateParentState;
  final Function(User) updateUserState;
  final User user;
  const UserForm(
      {Key key, this.updateParentState, this.user, this.updateUserState})
      : super(key: key);
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _userFormKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final UsersApi _usersApi = UsersApi();

  @override
  void initState() {
    _nameController.text = widget.user?.name ?? '';
    _userNameController.text = widget.user?.username ?? '';
    _emailController.text = widget.user?.email ?? '';
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _userNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void saveUserData() async {
    if (_userFormKey.currentState.validate()) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Processing Data')));

      try {
        User user = User(
          id: widget.user?.id ?? null,
          name: _nameController.text,
          username: _userNameController.text,
          email: _emailController.text,
        );

        if (widget.user == null) {
          widget.updateParentState(await _usersApi.createUserData(user));
          Navigator.pop(context);
        } else {
          widget.updateUserState(await _usersApi.updateUserData(user));
          Navigator.popUntil(context, (route) => route.isFirst);
        }
      } catch (e) {
        Scaffold.of(context)
            .removeCurrentSnackBar(reason: SnackBarClosedReason.dismiss);
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(
            'Error: $e',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  String btnTxt() {
    if (widget.user == null) return 'Submit';
    return 'Update User';
  }

  String validate(String val, String field) =>
      val.isEmpty ? '$field is required' : null;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _userFormKey,
      child: Container(
        child: Column(children: [
          RoundedInput(
            controller: _nameController,
            hint: 'Name',
            validator: (val) => validate(val, 'Name'),
          ),
          RoundedInput(
            controller: _userNameController,
            hint: 'Username',
            validator: (val) => validate(val, 'Username'),
          ),
          RoundedInput(
            controller: _emailController,
            hint: 'Email',
            validator: (val) => validate(val, 'Email'),
          ),
          RoundedElevatedbutton(
            onPress: saveUserData,
            text: btnTxt(),
          )
        ]),
      ),
    );
  }
}
