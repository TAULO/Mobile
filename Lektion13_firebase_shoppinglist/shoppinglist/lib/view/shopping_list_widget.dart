import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppinglist/model/ItemState.dart';
import 'package:shoppinglist/view/add_item_widget.dart';
import 'package:shoppinglist/view/filter_view.dart';
import 'package:shoppinglist/view/item_list_widget.dart';
import 'package:shoppinglist/view/location_view.dart';

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
        // Add Item btn
        Positioned(
          bottom: 25,
          right: 15,
          child: IconButton(
            color: Colors.white,
            icon: const Icon(
              Icons.add_shopping_cart_rounded,
              size: 40,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddItemPage(),
                ),
              );
            },
          ),
        ),
        // Google Maps btn
        Positioned(
          bottom: 25,
          right: 65,
          child: IconButton(
            icon: const Icon(
              Icons.map,
              size: 40,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LocationView()));
            },
          ),
        ),
        // filter ASC DESC btn
        Positioned(
          bottom: 25,
          left: 80,
          // lav en ny klasse til denne (sort asc desc)
          child: FloatingActionButton(
            onPressed: null,
            child: PopupMenuButton(
              color: Colors.white,
              itemBuilder: (context) => [
                // ASC
                PopupMenuItem(
                  onTap: () => Provider.of<ItemState>(context, listen: false)
                      .orderAmountAsc(),
                  child: const Text("Ascending"),
                ),
                // DESC
                PopupMenuItem(
                  onTap: () => Provider.of<ItemState>(context, listen: false)
                      .orderAmountDesc(),
                  child: const Text("Descending"),
                ),
              ],
            ),
          ),
        ),
        // Filter Deparments btn
        Positioned(
          bottom: 25,
          left: 15,
          child: FilterView(),
        ),
      ]),
      backgroundColor: Colors.lightBlueAccent,
    );
  }
}
