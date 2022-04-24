import 'package:bank_app/model/account.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Kind {
  String name;
  DateTime creationDate;

  Kind({required this.name, required this.creationDate});

  Map<String, dynamic> toJSON() {
    return {
      "name": name,
      "creationDate": creationDate,
    };
  }

  factory Kind.fromJSON(Map<String, dynamic> json) {
    return Kind(
      name: json["name"],
      creationDate: json["creationDate"],
    );
  }

  @override
  String toString() {
    return name;
  }
}
