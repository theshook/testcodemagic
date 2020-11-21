import 'package:flutter/material.dart';
import 'package:test_flutter/api/users_api.dart';
import 'package:test_flutter/models/user.dart';
import 'package:test_flutter/screens/home/home_card.dart';

class HomeList extends StatelessWidget {
  final UsersApi userApi;
  final List<User> users;
  final Function(int) removeUserFromList;
  final Function(int, User) undo;
  final Function(User) updateUserState;

  const HomeList({
    Key key,
    this.users,
    this.userApi,
    this.removeUserFromList,
    this.undo, this.updateUserState,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    void undoRemovedUser(int idx, User user) {
      /** can fire api call to restore the user */
      undo(idx, user);
    }

    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (BuildContext context, int idx) => Dismissible(
        key: ValueKey(users[idx].id),
        onDismissed: (dimissed) async {
          User tempUser = users[idx];
          await userApi.removeUserData(tempUser.id);
          removeUserFromList(idx);
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(
              'User removed from the list',
            ),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () => undoRemovedUser(idx, tempUser),
            ),
          ));
        },
        child: HomeCard(
          updateUserState: updateUserState,
          user: users[idx],
        ),
      ),
    );
  }
}
