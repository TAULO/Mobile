import 'package:bank_app/model/account.dart';
import 'package:bank_app/model/kind.dart';
import 'package:bank_app/states/firebase_database_state.dart';
import 'package:bank_app/view/account_homepage.dart';
import 'package:bank_app/view/account_listbuilder.dart';
import 'package:bank_app/view/add_account.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FirebaseDatabaseState(),
        ),
      ],
      child: BankApp(),
    ),
  );
}

class BankApp extends StatelessWidget {
  BankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.white70),
      home: AccountHomepage(),
    );
  }
}
