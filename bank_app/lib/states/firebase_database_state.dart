import 'package:bank_app/model/kind.dart';
import 'package:bank_app/model/transaction.dart';
import 'package:bank_app/service/firebase_database_service.dart';
import 'package:flutter/material.dart';

import '../model/account.dart';

class FirebaseDatabaseState extends ChangeNotifier {
  final FirebaseDatabaseService _service = FirebaseDatabaseService();

  final List<Account> _accounts = [];
  List<Account> get accounts => _accounts;
  int get accountsLength => _accounts.length;

  final List<MoneyTransaction> _moneyTransactions = [];
  List<MoneyTransaction> get moneyTransactions => _moneyTransactions;
  int get moneyTransactionsLength => _moneyTransactions.length;

  FirebaseDatabaseState() {
    addAllAccountsToDB();
  }

  void addAllAccountsToDB() {
    _service.addAllAccountsToDB(_accounts);
    print(_accounts);
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
    print("notified UPDATE");
    notifyListeners();
  }

  //----------------------------- Money Transaction -----------------------------

  void getMoneyTransactions({required Account account}) {
    _service.getMoneyTransactions(account, _moneyTransactions);
    notifyListeners();
  }

  void addMoneyTransaction(
      {required Account account, required MoneyTransaction transaction}) {
    _service.addMoneyTransaction(account, transaction);
    _moneyTransactions.add(transaction);
    notifyListeners();
  }
}
