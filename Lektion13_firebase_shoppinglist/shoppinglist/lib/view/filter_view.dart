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
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: "FilterBtn",
      onPressed: null,
      child: PopupMenuButton(
        itemBuilder: (context) => [
          PopupMenuItem(
            // ALL
            onTap: () {
              Provider.of<ItemState>(context, listen: false).addItemsFromDB();
            },
            child: const Text("All"),
          ),
          PopupMenuItem(
            // MEAT
            onTap: () {
              Provider.of<ItemState>(context, listen: false)
                  .filterDeparment(department: Departments.meat.name);
            },
            child: Text(Departments.meat.name),
          ),
          PopupMenuItem(
            // DELI
            onTap: () {
              Provider.of<ItemState>(context, listen: false)
                  .filterDeparment(department: Departments.deli.name);
            },
            child: Text(Departments.deli.name),
          ),
          PopupMenuItem(
            // HEALTH
            onTap: () {
              Provider.of<ItemState>(context, listen: false)
                  .filterDeparment(department: Departments.health.name);
            },
            child: Text(Departments.health.name),
          ),
          PopupMenuItem(
            // ALCOHOL
            onTap: () {
              Provider.of<ItemState>(context, listen: false)
                  .filterDeparment(department: Departments.alcohol.name);
            },
            child: Text(Departments.alcohol.name),
          ),
          PopupMenuItem(
            // SEAFOOD
            onTap: () {
              Provider.of<ItemState>(context, listen: false)
                  .filterDeparment(department: Departments.seafood.name);
            },
            child: Text(Departments.seafood.name),
          ),
        ],
      ),
    );
  }
}
