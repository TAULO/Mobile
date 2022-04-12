import 'package:flutter/rendering.dart';

enum Departments { meat, seafood, alcohol, health, deli }

class Item {
  String name;
  int amount;
  String department;
  String itemID;
  String uid;

  Item(this.name, this.amount, this.department, this.itemID, this.uid);

  factory Item.fromJSON(Map<String, dynamic> json, String itemID, String uid) {
    return Item(
      json["name"],
      json["amount"],
      json["department"],
      itemID,
      uid,
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      "name": name,
      "department": department,
      "amount": amount,
      "itemID": itemID,
      "uid": uid,
    };
  }

  List<String> getDeparmentsValues() {
    List<String> departments = [];
    for (var department in Departments.values) {
      departments.add(department.name);
    }
    return departments;
  }
}
