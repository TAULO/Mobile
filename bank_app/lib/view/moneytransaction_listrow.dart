import 'package:bank_app/model/account.dart';
import 'package:bank_app/model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl_browser.dart';

class MoneyTransactionListRow extends StatelessWidget {
  const MoneyTransactionListRow(
      {Key? key, required this.transaction, required this.account})
      : super(key: key);
  final Account account;
  final MoneyTransaction transaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: ListTile(
          title: Text(transaction.beneficiary),
          subtitle: Text(
              "${transaction.creationDate.day}/${transaction.creationDate.month}, ${transaction.creationDate.year}"),
          trailing: Text(
            "\$" + transaction.amount.toString(),
          )),
    );
  }
}
