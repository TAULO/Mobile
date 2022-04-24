//firebase: et array som indholder maps af fields amount, ben og date

import 'package:cloud_firestore/cloud_firestore.dart';

class MoneyTransaction {
  double amount;
  DateTime creationDate;
  String beneficiary;

  MoneyTransaction(
      {required this.amount,
      required this.creationDate,
      required this.beneficiary});

  factory MoneyTransaction.fromJSON(Map<String, dynamic> json) {
    DateTime timestampToDatetime = (json["creationDate"] as Timestamp).toDate();
    return MoneyTransaction(
        amount: json["amount"],
        creationDate: timestampToDatetime,
        beneficiary: json["beneficiary"]);
  }

  Map<String, dynamic> toJSON() {
    return {
      "amount": amount,
      "creationDate": creationDate,
      "beneficiary": beneficiary,
    };
  }

  @override
  String toString() {
    // TODO: implement toString
    // return "${creationDate.month} ${creationDate.day}, ${creationDate.year}";
    return beneficiary;
  }
}
