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

  @override
  String toString() {
    return name;
  }
}
