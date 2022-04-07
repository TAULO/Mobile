import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppinglist/model/Item.dart';
import 'package:shoppinglist/model/ItemState.dart';

class FilterDepartmentView extends StatefulWidget {
  FilterDepartmentView({Key? key}) : super(key: key);

  @override
  State<FilterDepartmentView> createState() => _FilterDepartmentViewState();
}

class _FilterDepartmentViewState extends State<FilterDepartmentView> {
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
    return PopupMenuButton(
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
    );
  }
}
