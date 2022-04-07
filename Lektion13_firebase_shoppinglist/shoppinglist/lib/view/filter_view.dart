import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppinglist/model/Item.dart';
import 'package:shoppinglist/model/ItemState.dart';

class FilterView extends StatefulWidget {
  FilterView({Key? key}) : super(key: key);

  @override
  State<FilterView> createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  PopupMenuItem departmentItem(Departments dep) {
    return PopupMenuItem(
        child: Text(dep.name),
        onTap: () {
          Provider.of<ItemState>(context, listen: false)
              .filterDeparment(department: dep.name);
        });
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: "FilterBtn",
      onPressed: null,
      child: PopupMenuButton(
        itemBuilder: (context) => [
          PopupMenuItem(
            onTap: () {
              Provider.of<ItemState>(context, listen: false).addItemsFromDB();
            },
            child: const Text("All"),
          ),
          departmentItem(Departments.alcohol),
          departmentItem(Departments.deli),
          departmentItem(Departments.health),
          departmentItem(Departments.meat),
          departmentItem(Departments.seafood),
        ],
      ),
    );
  }
}
