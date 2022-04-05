import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppinglist/model/ItemState.dart';
import '../model/Item.dart';

class UpdateItemPage extends StatefulWidget {
  Item updateItem;
  UpdateItemPage(this.updateItem);

  @override
  State<UpdateItemPage> createState() => _UpdateItemPageState();
}

class _UpdateItemPageState extends State<UpdateItemPage> {
  final GlobalKey<FormState> _globalKey = GlobalKey();
  String? _selectedDeparment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update " + widget.updateItem.name.toString()),
      ),
      backgroundColor: Colors.lightBlueAccent,
      body: Form(
        key: _globalKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration: const InputDecoration(hintText: "Name of Item"),
              initialValue: widget.updateItem.name,
              textAlign: TextAlign.center,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please give the item a name";
                }
                return null;
              },
              onSaved: (newName) => {
                if (newName != null) {widget.updateItem.name = newName}
              },
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: "Amount"),
              initialValue: widget.updateItem.amount.toString(),
              textAlign: TextAlign.center,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter an amount";
                }
                if (int.parse(value) <= 0) {
                  return "It is not possible to have less than 1 item";
                }
                return null;
              },
              onSaved: (newAmount) {
                if (newAmount != null) {
                  widget.updateItem.amount = int.parse(newAmount);
                }
              },
            ),
            DropdownButton(
              hint: const Text("Select a deparment"),
              value: widget.updateItem.department,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedDeparment = newValue;
                  if (_selectedDeparment != null) {
                    widget.updateItem.department =
                        _selectedDeparment.toString();
                  }
                });
              },
              items: widget.updateItem.getDeparmentsValues().map((deparment) {
                return DropdownMenuItem(
                  child: Text(deparment),
                  value: deparment,
                );
              }).toList(),
            ),
            ElevatedButton(
                onPressed: () async {
                  final form = _globalKey.currentState;
                  if (form!.validate()) {
                    form.save();
                    Provider.of<ItemState>(context, listen: false)
                        .updateItem(item: widget.updateItem);
                    Navigator.pop(context);
                  }
                },
                child: const Text("Update Item")),
          ],
        ),
      ),
    );
  }
}
