import 'package:flutter/material.dart';

import '../model/Pokemon.dart';
import '../network/Network_Service.dart';

class PokemonController extends ChangeNotifier {
  final List<Pokemon> _pokemons = [];
  final NetworkService networkService = NetworkService();

  _fetchJSON() async {
    dynamic json = await networkService.fetchJSONFrom(
        url: "https://pokeapi.co/api/v2/pokemon/?limit=10");
    List<dynamic> jsonPokemons = json["results"];

    jsonPokemons.forEach((element) {
      _pokemons.add(Pokemon.fromJSON(element));
    });
    notifyListeners();
  }

  PokemonController() {
    _fetchJSON();
  }

  int get pokemonLength {
    return _pokemons.length;
  }

  List<Pokemon> get pokemons {
    return _pokemons;
  }
}
