import 'package:bank_app/model/transaction.dart';
import 'package:bank_app/states/firebase_database_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/account.dart';

class AddMoneyTransactions extends StatefulWidget {
  AddMoneyTransactions({Key? key, required this.account}) : super(key: key);
  final Account account;

  @override
  State<AddMoneyTransactions> createState() => _AddMoneyTransactionsState();
}

class _AddMoneyTransactionsState extends State<AddMoneyTransactions> {
  final MoneyTransaction transaction = MoneyTransaction(
      amount: 0, creationDate: DateTime.now(), beneficiary: "beneficiary");

  final GlobalKey<FormState> _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white54,
        title: const Text(
          "New Transaction",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Form(
        key: _globalKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(hintText: "amount"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Insert an amount";
                }
                return null;
              },
              onSaved: (value) {
                if (value != null) {
                  transaction.amount = double.parse(value);
                }
              },
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: "Beneficiary name"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Insert an amount";
                }
                return null;
              },
              onSaved: (value) {
                if (value != null) {
                  transaction.beneficiary = value;
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Icon(Icons.add_circle_rounded),
          GestureDetector(
            onTap: () {
              final form = _globalKey.currentState;
              if (form!.validate()) {
                form.save();
                setState(() {
                  widget.account.setBalance = transaction.amount;
                });
                Navigator.pop(context);
                Provider.of<FirebaseDatabaseState>(context, listen: false)
                    .addMoneyTransaction(
                        account: widget.account, transaction: transaction);
              }
            },
            child: const Text(" Add Transaction",
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
