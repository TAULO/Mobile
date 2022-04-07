import 'package:flutter/rendering.dart';

enum Departments { meat, seafood, alcohol, health, deli }

class Item {
  String name;
  int amount;
  String department;
  String id;

  Item(this.name, this.amount, this.department, this.id);

  factory Item.fromJSON(Map<String, dynamic> json, String id) {
    return Item(
      json["name"],
      json["amount"],
      json["department"],
      id,
    );
  }

  get docID => id;

  set setDocID(String docId) {
    id = docId;
  }

  Map<String, dynamic> toJSON() {
    return {"name": name, "department": department, "amount": amount};
  }

  List<String> getDeparmentsValues() {
    List<String> departments = [];
    for (var department in Departments.values) {
      departments.add(department.name);
    }
    return departments;
  }
}
