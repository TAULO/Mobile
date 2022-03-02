import 'package:my_pokemon_app/network/Network_Service.dart';

class Pokemon {
  final String name;
  final String url;
  final String imgSrc;
  // filføj en element attribut senere

  static final NetworkService _networkService = NetworkService();

  Pokemon({required this.name, required this.url, required this.imgSrc});

  factory Pokemon.fromJSON(Map<String, dynamic> json) {
    return Pokemon(name: json["name"], url: json["url"], imgSrc: json["img"]);
  }

  Future<String> fetchImageURL() async {
    var imgJsonData = await _networkService.fetchJSONFrom(url: url);
    return imgJsonData["sprites"]["other"]["dream_world"]["official-artwork"];
  }
}
