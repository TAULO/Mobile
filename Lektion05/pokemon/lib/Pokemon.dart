import 'package:pokemon/Network_Service.dart';

class Pokemon {
  final String name;
  final String url;
  bool favorite = false;
  static final NetworkService _networkService = NetworkService();

  Pokemon({required this.name, required this.url});

  factory Pokemon.fromJSON(Map<String, dynamic> json) {
    return Pokemon(name: json["name"], url: json["url"]);
  }

  Future<String> fetchImageURL() async {
    var jsonData = await _networkService.fetchJSONFrom(url: url);
    return jsonData["sprites"]["other"]["official-artwork"]["front_default"];
  }
}
