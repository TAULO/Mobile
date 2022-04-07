import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoppinglist/model/Item.dart';
import '../service/FirebaseService.dart';

// tilføj filteringsmetoder her

class ItemState extends ChangeNotifier {
  final FirebaseService _service = FirebaseService();

  final List<Item> _listItem = [];
  List<Item> get getItems => _listItem;

  int get getCount => _listItem.length;

  ItemState() {
    addItemsFromDB();
  }

  void addItemsFromDB() {
    _service.addItemsFromDB(_listItem);
    notifyListeners();
  }

  void addItem({required Item item}) {
    _service.addItem(item.name, item.amount, item.department);
    _listItem.add(item);
    notifyListeners();
  }

  void deleteItem({required Item item}) {
    _service.deleteItem(item);
    _listItem.remove(item);
    notifyListeners();
  }

  void updateItem({required Item item}) {
    _service.updateItem(item, item.name, item.amount, item.department);
    notifyListeners();
  }

  void filterDeparment({required String department}) async {
    _listItem.clear();
    for (var item in await _service.filterDeparments(department)) {
      _listItem.add(Item.fromJSON(item, "0"));
    }
    notifyListeners();
  }

  void orderAmountAsc() async {
    _listItem.clear();
    for (var item in await _service.orderAmountAsc()) {
      if (item != null) _listItem.add(Item.fromJSON(item, "0"));
    }
    notifyListeners();
  }

  void orderAmountDesc() async {
    _listItem.clear();
    for (var item in await _service.orderAmountDesc()) {
      if (item != null) _listItem.add(Item.fromJSON(item, "0"));
    }
    notifyListeners();
  }
}
