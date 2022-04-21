import 'package:bank_app/states/firebase_database_state.dart';
import 'package:bank_app/view/account_listrow.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountListBuilder extends StatelessWidget {
  const AccountListBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FirebaseDatabaseState>(
      builder: (context, state, child) {
        return ListView.builder(
          itemCount: state.accountsLength,
          itemBuilder: (context, index) {
            return AccountListRow(account: state.accounts[index]);
          },
        );
      },
    );
  }
}
