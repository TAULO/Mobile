import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppinglist/model/LocationState.dart';
import 'package:shoppinglist/model/LoginState.dart';
import 'package:shoppinglist/service/FirebaseDatabase_Service.dart';
import 'package:shoppinglist/view/loginAuth_view.dart';
import 'package:shoppinglist/view/location_view.dart';
import 'package:shoppinglist/view/shopping_list_widget.dart';

import 'model/ItemState.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ItemState(),
        ),
        Provider(
          create: (context) => LoginState(),
        ),
        StreamProvider(
          create: (context) =>
              Provider.of<LoginState>(context, listen: false).getUserChanges,
          initialData: null,
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    LoginAuthView view = LoginAuthView();
    return MaterialApp(
      title: "Shopping App",
      theme: ThemeData(primaryColor: Colors.blue),
      home: LoginAuthView(),
    );
  }
}
