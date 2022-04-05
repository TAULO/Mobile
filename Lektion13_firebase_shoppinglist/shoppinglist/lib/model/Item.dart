enum Departments { meat, seafood, alcohol, health, deli }

class Item {
  String name;
  int amount;
  String department;

  Item({required this.name, required this.department, required this.amount});

  factory Item.fromJSON(Map<String, dynamic> json) {
    return Item(
        name: json["name"],
        department: json["department"],
        amount: json["amount"]);
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
