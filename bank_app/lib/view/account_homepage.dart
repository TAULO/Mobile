import 'package:flutter/material.dart';

import 'account_listbuilder.dart';
import 'add_account.dart';

class AccountHomepage extends StatelessWidget {
  const AccountHomepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white54,
        title: const Text(
          "Accounts",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: const AccountListBuilder(),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddAccount()),
              );
            },
            child: Row(
              children: const [
                Icon(Icons.add_circle),
                Text(
                  " New Account",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
