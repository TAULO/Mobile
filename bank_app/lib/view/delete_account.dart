import 'package:bank_app/model/account.dart';
import 'package:bank_app/view/account_homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../states/firebase_database_state.dart';

class DeleteAccount extends StatelessWidget {
  const DeleteAccount({Key? key, required this.account}) : super(key: key);
  final Account account;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.delete),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Delete ${account.name}"),
              content: Text("Are you sure you want to delete: ${account.name}?"
                  "\n"
                  "This action can not be reversed"),
              actions: [
                SimpleDialogOption(
                  child: const Text("cancel"),
                  onPressed: () => Navigator.pop(context),
                ),
                SimpleDialogOption(
                  child: const Text("delete"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => AccountHomepage()),
                        ));
                    Provider.of<FirebaseDatabaseState>(context, listen: false)
                        .removeAccount(account: account);
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
