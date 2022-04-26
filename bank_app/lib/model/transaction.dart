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

  set setAmount(value) {
    amount = value;
  }

  String monthName(DateTime currMonth) {
    switch (currMonth.month) {
      case 1:
        return "Jan";
      case 2:
        return "Feb";
      case 3:
        return "Mar";
      case 4:
        return "Apr";
      case 5:
        return "May";
      case 6:
        return "Jun";
      case 7:
        return "Jul";
      case 8:
        return "Aug";
      case 9:
        return "Sep";
      case 10:
        return "Ocb";
      case 11:
        return "Nov";
      case 12:
        return "Dec";
      default:
        return "Invalid month";
    }
  }

  @override
  String toString() {
    return beneficiary;
  }
}
