import 'package:bank_app/model/transaction.dart';
import 'package:bank_app/states/firebase_database_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/account.dart';

class AddMoneyTransactions extends StatefulWidget {
  const AddMoneyTransactions({Key? key, required this.account})
      : super(key: key);
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 75, 8, 8),
              child: TextFormField(
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  hintText: "amount",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                textAlign: TextAlign.center,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Insert an amount";
                  }
                  if (double.parse(value) == 0) {
                    return "Amount can not be 0";
                  }
                  if (widget.account.getBalance + double.parse(value) < 0) {
                    return "Insufficient funds";
                  }
                  return null;
                },
                onSaved: (value) {
                  if (value != null) {
                    transaction.setAmount = double.parse(value);
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: "Beneficiary name",
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                textAlign: TextAlign.center,
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
