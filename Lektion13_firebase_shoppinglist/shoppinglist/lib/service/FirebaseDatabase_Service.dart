import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shoppinglist/model/ItemState.dart';
import 'package:shoppinglist/service/FirebaseAuth_Service.dart';
import '../model/Item.dart';

class FirebaseService {
  final CollectionReference _items =
      FirebaseFirestore.instance.collection(_firestoreCollectionName);

  Stream<QuerySnapshot<Map<String, dynamic>>>? itemsStream;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference get getFirestoreCol => _items;

  static const String _firestoreCollectionName = "Items";
  static final String uid = FirebaseAuth.instance.currentUser!.uid;

  FirebaseService();

  void addItemsFromDB(List<Item> itemList) {
    itemsStream = firestore
        .collection(_firestoreCollectionName)
        .where("uid", isEqualTo: uid)
        .snapshots();
    itemsStream!.listen((snapshot) {
      itemList.clear();
      snapshot.docs.forEach((element) {
        itemList.add(Item.fromJSON(element.data(), element.id,
            FirebaseAuth.instance.currentUser!.uid));
      });
    });
  }

  void addItem(String name, int amount, String department) {
    Item item = Item(name, amount, department, "0", uid);
    _items
        .add(item.toJSON())
        .then((value) => item.itemID = value.id)
        .then((value) => print(item.itemID.toString()));
  }

  Future<void> deleteItem(Item item) {
    return _items
        .doc(item.itemID)
        .delete()
        .then((value) => print(item.name + " was deleted"))
        .catchError((erorr) => print("Failed to delete: $erorr"));
  }

  void updateItem(Item item, String name, int amount, String department) {
    item = Item(name, amount, department, item.itemID, uid);
    _items
        .doc(item.itemID)
        .update(item.toJSON())
        .then((value) => print("Updated: $name"))
        .catchError((error) => print("Faield to udpate $error"));
  }

  filterDeparments(String department) {
    return _items
        .where("uid", isEqualTo: uid)
        .where("department", isEqualTo: department)
        .get()
        .then((value) => value.docs.map((e) => e.data()));
  }

  orderAmountDesc() {
    return _items
        .where("uid", isEqualTo: uid)
        .orderBy("amount", descending: true)
        .get()
        .then((value) => value.docs.map((e) => e.data()));
  }

  orderAmountAsc() {
    return _items
        .where("uid", isEqualTo: uid)
        .orderBy("amount", descending: false)
        .get()
        .then((value) => value.docs.map((e) => e.data()));
  }

  // ved ikke om disse skal anvendes
  orderAlphabeticalAsc() {
    return _items
        .where("uid", isEqualTo: uid)
        .orderBy("name", descending: true)
        .get()
        .then((value) => value.docs.map((e) => e.data()));
  }

  orderAlphabeticalDesc() {
    return _items
        .where("uid", isEqualTo: uid)
        .orderBy("name", descending: false)
        .get()
        .then((value) => value.docs.map((e) => e.data()));
  }
}
