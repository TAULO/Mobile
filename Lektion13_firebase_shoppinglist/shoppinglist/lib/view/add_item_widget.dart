import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppinglist/model/ItemState.dart';
import '../model/Item.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({Key? key}) : super(key: key);

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final GlobalKey<FormState> _globalKey = GlobalKey();

  Item item = Item("name", 0, "department", "docID");
  String? _selectedDeparment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Items"),
      ),
      backgroundColor: Colors.lightBlueAccent,
      body: Form(
        key: _globalKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration: const InputDecoration(hintText: "Name of Item"),
              textAlign: TextAlign.center,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please give the item a name";
                }
                return null;
              },
              onSaved: (newName) => {
                if (newName != null) {item.name = newName}
              },
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: "Amount"),
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
                  item.amount = int.parse(newAmount);
                }
              },
            ),
            DropdownButton(
              hint: const Text("Select a deparment"),
              value: _selectedDeparment,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedDeparment = newValue;
                  if (_selectedDeparment != null) {
                    item.department = _selectedDeparment.toString();
                  }
                });
              },
              items: item.getDeparmentsValues().map((deparment) {
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
                      .addItem(item: item);
                  Navigator.pop(context);
                }
              },
              child: const Text("Add Item"),
            ),
          ],
        ),
      ),
    );
  }
}
