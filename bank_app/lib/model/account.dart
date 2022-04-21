import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'transaction.dart';
import 'kind.dart';

class Account {
  static const String _collectionName = "bank_database";

  String name;
  Kind kind;
  late String iban;
  late String itemID;

  final double _balance = 200000.0;

  final List<MoneyTransaction> _transactions = [];
  List<MoneyTransaction> get transactions => _transactions;

  Account({
    required this.name,
    required this.kind,
  }) {
    iban = generateIbanNumber();
    itemID = FirebaseFirestore.instance.collection(_collectionName).doc().id;
    print("accid: " + itemID);
  }

  double get getBalance {
    return _balance;
  }

  String? get getItemID => itemID;

  set setItemID(id) {
    itemID = id;
  }

  factory Account.fromJSON(Map<String, dynamic> json, String itemID) {
    return Account(
      name: json["name"],
      kind: json["kind"],
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      "name": name,
      "iban": iban,
      "kind": kind.toJSON(),
      "itemID": itemID,
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
    return countryCodes.elementAt(rng.nextInt(countryCodes.length)) +
        randomNumbers;
  }

  @override
  String toString() {
    return name + " " + kind.toString();
  }
}
