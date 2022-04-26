import 'package:bank_app/model/kind.dart';
import 'package:bank_app/model/transaction.dart';
import 'package:bank_app/service/firebase_database_service.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../model/account.dart';
import '../states/firebase_database_state.dart';
import 'moneytransaction_listrow.dart';

class MoneytransactionListBuilder extends StatelessWidget {
  const MoneytransactionListBuilder({Key? key, required this.account})
      : super(key: key);

  final Account account;

  @override
  Widget build(BuildContext context) {
    return Consumer<FirebaseDatabaseState>(
      builder: (context, state, child) {
        return ListView.builder(
          itemCount: account.transactions.length,
          itemBuilder: (context, index) {
            return MoneyTransactionListRow(
              transaction: account.transactions[index],
              account: account,
            );
          },
        );
      },
    );
  }
}
