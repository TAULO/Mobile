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
  Text departmentEmojies(String department) {
    switch (department) {
      case "alcohol":
        {
          return const Text("🍷");
          // return Text(parser.parseEmojis(parser.getEmoji("🍷").toString())[0]);
        }
      case "deli":
        {
          return const Text("🍱");
          // return Text(parser.parseEmojis(parser.getEmoji("🍱").toString())[0]);
        }
      case "health":
        {
          return const Text("💊");
          // return Text(parser.parseEmojis(parser.getEmoji("💊").toString())[0]);
        }
      case "meat":
        {
          return const Text("🥩");
          // return Text(parser.parseEmojis(parser.getEmoji("🥩").toString())[0]);
        }
      case "seafood":
        {
          // return Text(parser.parseEmojis(parser.getEmoji("🦞").toString())[0]);
          return const Text("🦞");
        }
      default:
        {
          return const Text("🙉");
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Container(
        color: const Color.fromARGB(255, 136, 206, 238),
        child: ListTile(
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
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(widget.item.department),
              const Padding(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 2)),
              departmentEmojies(widget.item.department),
            ],
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
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UpdateItemPage(widget.item),
              ),
            );
          },
          onLongPress: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text("Do you want to delete ${widget.item.name}?"),
                  actions: [
                    SimpleDialogOption(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("No"),
                    ),
                    SimpleDialogOption(
                      onPressed: () {
                        Provider.of<ItemState>(context, listen: false)
                            .deleteItem(item: widget.item);
                        Navigator.pop(context);
                      },
                      child: const Text("Delete"),
                    ),
                  ],
                );
              },
            );
          },
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
