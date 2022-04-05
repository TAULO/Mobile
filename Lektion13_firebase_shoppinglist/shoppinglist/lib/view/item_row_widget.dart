import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppinglist/model/ItemState.dart';
import 'package:shoppinglist/view/update_item_widget.dart';

import '../model/Item.dart';

class ItemRow extends StatefulWidget {
  final Item item;

  const ItemRow({Key? key, required this.item}) : super(key: key);

  @override
  State<ItemRow> createState() => _ItemRowState();
}

class _ItemRowState extends State<ItemRow> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Container(
        color: const Color.fromARGB(255, 136, 206, 238),
        child: ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UpdateItemPage(widget.item),
              ),
            );
          },
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          title: Text(
            widget.item.name,
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          subtitle: Text(
            widget.item.department,
            textAlign: TextAlign.center,
          ),
          leading: Container(
            padding: const EdgeInsets.only(right: 12.0),
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(width: 1.0, color: Colors.black),
              ),
            ),
            child: Text(
              widget.item.amount.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.w300,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              Provider.of<ItemState>(context, listen: false)
                  .deleteItem(item: widget.item);
            },
          ),
        ),
      ),
    );
  }
}
