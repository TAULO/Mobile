import 'package:bank_app/model/account.dart';
import 'package:bank_app/states/firebase_database_state.dart';
import 'package:bank_app/view/add_moneytransaction.dart';
import 'package:bank_app/view/moneytransaction_listbuilder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MoneyTransactionHomepage extends StatelessWidget {
  const MoneyTransactionHomepage({Key? key, required this.account})
      : super(key: key);
  final Account account;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white54,
        title: const Text(
          "Transactions",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: MoneytransactionListBuilder(account: account),
      floatingActionButton: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => AddMoneyTransactions(
                          account: account,
                        ))));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Icon(Icons.add_circle_rounded),
              Text(
                " New Transaction",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          )),
    );
  }
}
