import 'package:bank_app/model/transaction.dart';
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
        list.add(Account.fromJSON(element.data()));
      });
    });
  }

  void addAccount(String name, Kind kind, List<Account> list) {
    Account account = Account(
        name: name,
        kind: kind,
        iban: "iban",
        itemID: _collectionReference.doc().id);
    account.generateIbanNumber();
    list.add(account);
    _collectionReference.doc(account.getItemID).set(account.toJSON()).onError(
        (error, stackTrace) =>
            print("Something went wrong when added: $name | $error"));
  }

  void removeAccount(Account account) {
    _collectionReference
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

  //----------------------------- Money Transaction -----------------------------

  void getMoneyTransactions(Account account) {
    itemsStream = firestore.collection(_collectionName).snapshots();
    itemsStream!.listen((event) {
      event.docs.forEach((element) {
        if (element.get("itemID") == account.itemID) {
          account.transactions.clear();
          List<dynamic> list = element.get("transactions");
          for (var item in list) {
            account.transactions.add(MoneyTransaction.fromJSON(item));
          }
        }
      });
    });
  }

  void addMoneyTransaction(Account account, MoneyTransaction transaction) {
    _collectionReference.doc(account.itemID).update({
      "transactions": FieldValue.arrayUnion([transaction.toJSON()])
    }).then((value) => print("added: ${transaction.amount}"));
  }
}
