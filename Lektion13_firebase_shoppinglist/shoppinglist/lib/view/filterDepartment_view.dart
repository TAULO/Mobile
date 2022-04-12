import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:shoppinglist/model/Item.dart';
import 'package:shoppinglist/model/ItemState.dart';

class FilterDepartmentView extends StatefulWidget {
  FilterDepartmentView({Key? key}) : super(key: key);

  @override
  State<FilterDepartmentView> createState() => _FilterDepartmentViewState();
}

// FIX: if a deparment is not chosen and the user then tires to update the item
// a null expcetion will accur!

// FIX: if the user filters the itemsID will be zero and the doc cant find the item
class _FilterDepartmentViewState extends State<FilterDepartmentView> {
  PopupMenuItem departmentItem(Departments dep) {
    return PopupMenuItem(
      child: Text(dep.name),
      onTap: () {
        try {
          Provider.of<ItemState>(context, listen: false)
              .filterDeparment(department: dep.name);
        } on FirebaseException catch (e) {
          print("suub bitch");
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
          onTap: () {
            try {
              Provider.of<ItemState>(context, listen: false).addItemsFromDB();
            } on FirebaseAuthException catch (e) {
              print("heyyy??");
            }
          },
          child: const Text("All"),
        ),
        departmentItem(Departments.alcohol),
        departmentItem(Departments.deli),
        departmentItem(Departments.health),
        departmentItem(Departments.meat),
        departmentItem(Departments.seafood),
      ],
    );
  }
}
