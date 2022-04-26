import 'package:bank_app/model/account.dart';
import 'package:bank_app/model/transaction.dart';
import 'package:flutter/material.dart';

class MoneyTransactionListRow extends StatelessWidget {
  const MoneyTransactionListRow(
      {Key? key, required this.transaction, required this.account})
      : super(key: key);
  final Account account;
  final MoneyTransaction transaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: ListTile(
        title: Text(
          transaction.beneficiary,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        subtitle: Text(
            "${transaction.creationDate.day}. ${transaction.monthName(transaction.creationDate)}, ${transaction.creationDate.year}"),
        trailing: Transform.translate(
          offset: const Offset(0, -10),
          child: Text(
            "\$" + transaction.amount.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
        ),
      ),
    );
  }
}
