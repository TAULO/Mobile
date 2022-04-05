// TODO configure firebase :
// Add
// Delete
// Find
// ignore_for_file: avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model/Item.dart';

// later deparment should be added
class FirebaseService {
  final CollectionReference _items =
      FirebaseFirestore.instance.collection("Items");

  Stream<QuerySnapshot<Map<String, dynamic>>>? itemsStream;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference get getFirestoreCol => _items;

  // FirebaseService({required this.items});
  FirebaseService();

  // void enMetode(List<Item> itemList) {
  //   _items.snapshots().listen((documents) {
  //     itemList.clear();
  //     for (var doc in documents.docs) {
  //       itemList.add(doc.data());
  //     }
  //   });
  // }

  void addItemsFromDB(List<Item> itemList) {
    itemsStream = firestore.collection("Items").snapshots();
    itemsStream!.listen((snapshot) {
      itemList.clear();
      snapshot.docs.forEach((element) {
        itemList.add(Item.fromJSON(element.data()));
      });
    });
  }

  void addItem(String name, String department, int amount) {
    Item item = Item(name: name, department: department, amount: amount);
    // _items
    //     .add(item.toJson())
    //     .then((value) => print("added: " + name))
    //     .catchError((eror) => print("Failed to add item: $name"));
    _items
        .doc(item.name)
        .set(item.toJSON())
        .then((value) => print("Added: " + name))
        .catchError((error) => print("Failed to add: $error"));
  }

  Future<void> deleteItem(Item item) {
    return _items
        .doc(item.name)
        .delete()
        .then((value) => (print(item.name + " was deleted")))
        .catchError((erorr) => print("Failed to delete: $erorr"));
  }

  void updateItem(Item item, String name, String department, int amount) async {
    item = Item(name: name, department: department, amount: amount);
    _items
        .doc(name)
        .update(item.toJSON())
        .then((value) => print("Updated: $name"))
        .catchError((error) => print("Faield to udpate $error"));
  }

  getDocID(String name) async {
    dynamic docID = _items
        .where("name", isEqualTo: name)
        .get()
        .then((value) => value.docs.map((e) => e.id));

    for (var id in await docID) {
      return id;
    }
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
}
