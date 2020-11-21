import 'package:flutter/material.dart';
import 'package:test_flutter/models/user.dart';
import 'package:test_flutter/screens/user/user.dart';

class HomeCard extends StatelessWidget {
  final User user;
  final Function(User) updateUserState;
  const HomeCard({Key key, this.user, this.updateUserState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => UserScreen(
            user: user,
            updateUserState: updateUserState,
          ),
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          border: Border.all(
            width: 0.5,
            color: Colors.black,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(user.username),
          Text(user.email),
        ]),
      ),
    );
  }
}
