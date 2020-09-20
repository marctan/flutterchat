import 'package:flutter/material.dart';

class Users extends ChangeNotifier {
  
  List users;

  setUsers(usersList) {
    users = usersList;
    notifyListeners();
  }

  List get getUsers {
    return users;
  }
}