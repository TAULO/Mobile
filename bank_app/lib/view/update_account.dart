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
            ElevatedButton(
                onPressed: () {
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
                child: const Text("add"))
          ],
        ),
      ),
      floatingActionButton: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Delete ${widget.account.name}"),
                content: Text(
                    "Are you sure you want to delete: ${widget.account.name}?"
                    "\n"
                    "This action can not be reversed"),
                actions: [
                  SimpleDialogOption(
                    child: const Text("cancel"),
                    onPressed: () => Navigator.pop(context),
                  ),
                  SimpleDialogOption(
                    child: const Text("delete"),
                    onPressed: () => Provider.of<FirebaseDatabaseState>(context,
                            listen: false)
                        .removeAccount(account: widget.account),
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }
}
