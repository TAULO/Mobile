import 'package:bank_app/view/delete_account.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/account.dart';
import '../states/firebase_database_state.dart';

class UpdateAccount extends StatefulWidget {
  const UpdateAccount({Key? key, required this.account}) : super(key: key);
  final Account account;

  @override
  State<UpdateAccount> createState() => _UpdateAccountState();
}

class _UpdateAccountState extends State<UpdateAccount> {
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
        title: Text(
          "Update ${widget.account.name}",
          style: const TextStyle(color: Colors.black),
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
                initialValue: widget.account.name,
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
                    widget.account.name = value;
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
                  widget.account.kind.name = _selectedKind;
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
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 165),
            child: DeleteAccount(account: widget.account),
          ),
          GestureDetector(
            onTap: () {
              final form = _globalKey.currentState;
              if (form!.validate()) {
                try {
                  form.save();
                  Provider.of<FirebaseDatabaseState>(context, listen: false)
                      .updateAccount(account: widget.account);
                  Navigator.pop(context);
                } on FormatException catch (e) {
                  setState(() {
                    hasError = true;
                    hasErrorText = e.message;
                  });
                }
              }
            },
            child: Row(
              children: const [
                Icon(Icons.add_circle_rounded),
                Text(
                  " Update Account",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
