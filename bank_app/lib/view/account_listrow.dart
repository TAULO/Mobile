import 'package:bank_app/model/account.dart';
import 'package:bank_app/states/firebase_database_state.dart';
import 'package:bank_app/view/moneytransaction_homepage.dart';
import 'package:bank_app/view/update_account.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountListRow extends StatefulWidget {
  const AccountListRow({Key? key, required this.account}) : super(key: key);
  final Account account;

  @override
  State<AccountListRow> createState() => _AccountListRowState();
}

class _AccountListRowState extends State<AccountListRow> {
  // double calculateBalance() {
  //   return Provider.of<FirebaseDatabaseState>(context)
  //       .calculateBalance(widget.account);
  // }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 10,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        title: Text(
          widget.account.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        subtitle: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(widget.account.kind.toString()),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(widget.account.iban.toString()),
            ),
          ],
        ),
        trailing: Transform.translate(
          offset: const Offset(0, -10),
          child: Text(
            "\$" + widget.account.getBalance.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        onTap: () {
          Provider.of<FirebaseDatabaseState>(context, listen: false)
              .getMoneyTransactions(account: widget.account);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) =>
                  MoneyTransactionHomepage(account: widget.account)),
            ),
          );
        },
        onLongPress: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Update ${widget.account.name}"),
                content: Text("Do you want to update ${widget.account.name}?"),
                actions: [
                  SimpleDialogOption(
                    child: const Text("cancel"),
                    onPressed: () => Navigator.pop(context),
                  ),
                  SimpleDialogOption(
                    child: const Text("yes"),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateAccount(
                            account: widget.account,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
