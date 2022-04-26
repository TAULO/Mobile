import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'transaction.dart';
import 'kind.dart';

class Account {
  String name;
  Kind kind;
  late String iban;
  late String itemID;

  double _balance = 0;

  final List<MoneyTransaction> _transactions = [];

  Account(
      {required this.name,
      required this.kind,
      required this.iban,
      required this.itemID});

  List<MoneyTransaction> get transactions => _transactions;

  double get getBalance {
    double totalTransactions = 0;
    for (var item in _transactions) {
      totalTransactions += item.amount;
    }
    _balance = totalTransactions;
    return _balance;
  }

  set setBalance(double value) {
    if (value < 0) {
      _balance -= value;
    } else if (value > 0) {
      _balance += value;
    }
  }

  get getItemID => itemID;

  factory Account.fromJSON(Map<String, dynamic> json) {
    DateTime timestampToDatetime =
        (json["kind"]["creationDate"] as Timestamp).toDate();
    return Account(
      name: json["name"],
      kind: Kind(name: json["kind"]["name"], creationDate: timestampToDatetime),
      iban: json["iban"],
      itemID: json["itemID"],
    );
  }

  Map<String, dynamic> toJSON() {
    List<dynamic> moneyTransactions = [];
    if (_transactions.isEmpty) {
      print("list is empty");
    } else {
      for (var item in _transactions) {
        Map<String, dynamic> transactions = item.toJSON();
        moneyTransactions.add(transactions);
      }
    }
    return {
      "name": name,
      "iban": iban,
      "kind": kind.toJSON(),
      "itemID": itemID,
      "transactions": moneyTransactions,
    };
  }

  String generateIbanNumber() {
    List<String> countryCodes = [
      "US",
      "DK",
      "UK",
      "NO",
    ];
    var rng = Random();
    String randomNumbers = "";
    for (int i = 0; i < 12; i++) {
      if (i == 0 || i == 4 || i == 8) {
        randomNumbers += " ";
      }
      randomNumbers += rng.nextInt(10).toString();
    }
    return iban = countryCodes.elementAt(rng.nextInt(countryCodes.length)) +
        randomNumbers;
  }

  @override
  String toString() {
    return name + " " + kind.toString();
  }
}
