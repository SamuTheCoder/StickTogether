import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stick_together_app/database/db.dart';
import 'package:stick_together_app/models/Position.dart';

class AccountAcrchive extends ChangeNotifier {
  late Database db;
  List<Position> _account = [];

  List<Position> get account => _account;

  AccountAcrchive() {
    _initRepository();
  }
  _initRepository() async {
    await _getAccount();
  }

  _getAccount() async {
    db = await DB.instance.database;
    List acnt = await db.query('account');
    notifyListeners();
  }

  setData(List<Position> user) async {
    db = await DB.instance.database;
    db.update('account',
        {'userName': user[0], 'email': user[1], 'password': user[2]});
    notifyListeners();
  }
}
