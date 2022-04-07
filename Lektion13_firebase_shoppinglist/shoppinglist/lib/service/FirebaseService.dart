import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model/Item.dart';

class FirebaseService {
  final CollectionReference _items =
      FirebaseFirestore.instance.collection("Items");

  Stream<QuerySnapshot<Map<String, dynamic>>>? itemsStream;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference get getFirestoreCol => _items;

  // FirebaseService({required this.items});
  FirebaseService();

  void addItemsFromDB(List<Item> itemList) {
    itemsStream = firestore.collection("Items").snapshots();
    itemsStream!.listen((snapshot) {
      itemList.clear();
      snapshot.docs.forEach((element) {
        itemList.add(Item.fromJSON(element.data(), element.id));
      });
    });
  }

  void addItem(String name, int amount, String department) {
    Item item = Item(name, amount, department, "0");
    // _items
    //     .doc(item.name)
    //     .set(item.toJSON())
    //     .then((value) => print("Added: " + name))
    //     .catchError((error) => print("Failed to add: $error"));
    _items.add(item.toJSON()).then((value) => item.id = value.id);
  }

  Future<void> deleteItem(Item item) {
    print(item.id);
    return _items
        .doc(item.id)
        .delete()
        .then((value) => (print(item.name + " was deleted")))
        .catchError((erorr) => print("Failed to delete: $erorr"));
  }

  void updateItem(Item item, String name, int amount, String department) async {
    item = Item(name, amount, department, item.id);
    _items
        .doc(item.id)
        .update(item.toJSON())
        .then((value) => print("Updated: $name"))
        .catchError((error) => print("Faield to udpate $error"));
  }

  filterDeparments(String department) {
    return _items
        .where("department", isEqualTo: department)
        .get()
        .then((value) => value.docs.map((e) => e.data()));
  }

  orderAmountDesc() {
    return _items
        .orderBy("amount", descending: true)
        .get()
        .then((value) => value.docs.map((e) => e.data()));
  }

  orderAmountAsc() {
    return _items
        .orderBy("amount", descending: false)
        .get()
        .then((value) => value.docs.map((e) => e.data()));
  }

  // ved ikke om disse skal anvendes
  orderAlphabeticalAsc() {
    return _items
        .orderBy("name", descending: true)
        .get()
        .then((value) => value.docs.map((e) => e.data()));
  }

  orderAlphabeticalDesc() {
    return _items
        .orderBy("name", descending: false)
        .get()
        .then((value) => value.docs.map((e) => e.data()));
  }
}
