import 'package:flutter/material.dart';
import 'package:test_flutter/api/users_api.dart';
import 'package:test_flutter/models/user.dart';
import 'package:test_flutter/screens/home/home_list.dart';
import 'package:test_flutter/screens/user/user_create.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  final GlobalKey<_HomeScreen> homeScreenKey = GlobalKey<_HomeScreen>();
  UsersApi _usersApi = UsersApi();
  List<User> _usersList = [];

  @override
  void initState() {
    _fetchUsersData();
    super.initState();
  }

  Future<void> _fetchUsersData() async {
    try {
      List<User> _tempUser = await _usersApi.getUsersData();
      setState(() => _usersList = _tempUser);
    } catch (e) {
      print("Error: $e");
    }
  }

  void addUserList(User user) => setState(() => _usersList.add(user));
  void removeUserFromList(int idx) => setState(() => _usersList.removeAt(idx));
  void undoRemovedUser(int idx, User user) =>
      setState(() => _usersList.insert(idx, user));
  void updateUserList(User user) {
    int idx = _usersList.indexWhere((u) => u.id == user.id);
    if (idx != -1) setState(() => _usersList[idx] = user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: HomeList(
        userApi: _usersApi,
        removeUserFromList: removeUserFromList,
        updateUserState: updateUserList,
        undo: undoRemovedUser,
        users: _usersList,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => CreateUserScreen(
              updateParentState: addUserList,
            ),
          ),
        ),
      ),
    );
  }
}
