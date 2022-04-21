import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/account.dart';
import '../model/kind.dart';

class FirebaseDatabaseService {
  static const String _collectionName = "bank_database";

  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection(_collectionName);
  CollectionReference get getCollection => _collectionReference;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot<Map<String, dynamic>>>? itemsStream;

  FirebaseDatabaseService();

  void addAllAccountsToDB(List<Account> list) {
    itemsStream = firestore.collection(_collectionName).snapshots();
    itemsStream!.listen((event) {
      list.clear();
      event.docs.forEach((element) {
        list.add(Account.fromJSON(element.data(), element.id));
      });
    });
  }

  void addAccount(String name, Kind kind, List<Account> list) {
    Account account = Account(name: name, kind: kind);
    list.add(account);
    _collectionReference.doc(account.getItemID).set(account.toJSON()).onError(
        (error, stackTrace) =>
            print("Something went wrong when added: $name | $error"));
  }

  Future<void> removeAccount(Account account) {
    return _collectionReference
        .doc(account.getItemID)
        .delete()
        .then((value) => print("${account.name} was deleted"))
        .catchError((onError) => print(
            "Something went wrong when deleted: ${account.name} | $onError"));
  }

  void updateAccount(Account account) {
    _collectionReference
        .doc(account.itemID)
        .update(account.toJSON())
        .then((value) => print("Updated ${account.name}"))
        .catchError((onError) => print(
            "Something went wrong when updated: ${account.name} | $onError"));
  }
}
