import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppinglist/model/ItemState.dart';
import 'package:shoppinglist/view/add_item_widget.dart';
import 'package:shoppinglist/view/filter_view.dart';
import 'package:shoppinglist/view/item_list_widget.dart';

class ShoppingListPage extends StatefulWidget {
  ShoppingListPage({Key? key}) : super(key: key);

  @override
  State<ShoppingListPage> createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping List"),
      ),
      body: Stack(children: [
        const ShoppingItemList(),
        Positioned(
          bottom: 20,
          left: 15,
          child: FilterView(),
        ),
        Positioned(
          bottom: 20,
          right: 15,
          child: FloatingActionButton(
            heroTag: "AddBtn",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddItemPage(),
                ),
              );
            },
            child: const Icon(Icons.add_shopping_cart_rounded),
          ),
        ),
        Positioned(
          bottom: 80,
          child: FloatingActionButton(onPressed: () {
            Provider.of<ItemState>(context, listen: false).orderAmountAsc();
          }),
        ),
        Positioned(
          bottom: 80,
          left: 50,
          child: FloatingActionButton(onPressed: () {
            Provider.of<ItemState>(context, listen: false).orderAmountDesc();
          }),
        ),
      ]),
      backgroundColor: Colors.lightBlueAccent,
    );
  }
}
