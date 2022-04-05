import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppinglist/model/ItemState.dart';

import 'item_row_widget.dart';

class ShoppingItemList extends StatefulWidget {
  const ShoppingItemList({Key? key}) : super(key: key);

  @override
  State<ShoppingItemList> createState() => _ShoppingItemListState();
}

class _ShoppingItemListState extends State<ShoppingItemList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ItemState>(
      builder: (context, state, child) {
        return ListView.builder(
          itemCount: state.getCount,
          itemBuilder: (context, index) {
            return ItemRow(item: state.getItems[index]);
          },
        );
      },
    );
  }
}
