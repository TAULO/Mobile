import 'package:bank_app/model/kind.dart';
import 'package:bank_app/states/firebase_database_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/account.dart';

class AddAccount extends StatefulWidget {
  const AddAccount({Key? key}) : super(key: key);

  @override
  State<AddAccount> createState() => _AddAccountState();
}

class _AddAccountState extends State<AddAccount> {
  final Kind kind = Kind(name: "", creationDate: DateTime.now());
  String accName = "";

  // fix dis
  final GlobalKey<FormState> _globalKey = GlobalKey();

  String _selectedKind = "Savings";
  List<Text> kindNamesList() {
    return const [
      Text("Savings"),
      Text("Investement"),
      Text("Vaction"),
    ];
  }

  String hasErrorText = "";
  bool hasError = false;
  Widget kindHasErrorWidget() {
    if (hasError) {
      return Text(hasErrorText, style: const TextStyle(color: Colors.red));
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Create Account",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white54,
      ),
      body: Form(
        key: _globalKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: TextFormField(
                decoration: const InputDecoration(hintText: "Account name"),
                textAlign: TextAlign.center,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "fill this field";
                  }
                  return null;
                },
                onSaved: (value) {
                  if (value != null) {
                    accName = value;
                  }
                },
              ),
            ),
            DropdownButton(
              hint: const Text("select a kind"),
              value: _selectedKind,
              onChanged: (String? value) {
                setState(() {
                  _selectedKind = value.toString();
                  kind.name = _selectedKind;
                });
              },
              items: kindNamesList().map(
                (Text textWidget) {
                  return DropdownMenuItem(
                    child: textWidget,
                    value: textWidget.data,
                  );
                },
              ).toList(),
            ),
            kindHasErrorWidget(),
            ElevatedButton(
                onPressed: () {
                  final form = _globalKey.currentState;
                  if (form!.validate()) {
                    try {
                      form.save();
                      Provider.of<FirebaseDatabaseState>(context, listen: false)
                          .addAccount(accName: accName, kind: kind);
                      Navigator.pop(context);
                    } on FormatException catch (e) {
                      setState(() {
                        hasError = true;
                        hasErrorText = e.message;
                      });
                    }
                  }
                },
                child: const Text("add"))
          ],
        ),
      ),
    );
  }
}
