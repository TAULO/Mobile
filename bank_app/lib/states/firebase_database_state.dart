import 'package:bank_app/model/kind.dart';
import 'package:bank_app/service/firebase_database_service.dart';
import 'package:flutter/material.dart';

import '../model/account.dart';

class FirebaseDatabaseState extends ChangeNotifier {
  final FirebaseDatabaseService _service = FirebaseDatabaseService();
  List<Account> _accounts = [];
  List<Account> get accounts => _accounts;
  int get accountsLength => _accounts.length;

  FirebaseDatabaseState();

  void addAllAccountsToDB() {
    _service.addAllAccountsToDB(_accounts);
    notifyListeners();
  }

  void addAccount({required String accName, required Kind kind}) {
    if (kind.name == "") throw const FormatException("Pick a kind");
    _service.addAccount(accName, kind, _accounts);
    notifyListeners();
  }

  void removeAccount({required Account account}) {
    _service.removeAccount(account);
    _accounts.remove(account);
    notifyListeners();
  }

  void updateAccount({required Account account}) {
    _service.updateAccount(account);
    notifyListeners();
  }
}
