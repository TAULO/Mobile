import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppinglist/model/LocationState.dart';
import 'package:shoppinglist/service/FirebaseService.dart';
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
        ChangeNotifierProvider(
          create: (context) => LocationState(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Shopping App",
      theme: ThemeData(primaryColor: Colors.blue),
      home: ShoppingListPage(),
    );
  }
}
