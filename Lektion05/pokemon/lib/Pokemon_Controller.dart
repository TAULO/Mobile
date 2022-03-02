import 'package:flutter/material.dart';
import 'package:pokemon/Network_Service.dart';

import 'Pokemon.dart';

class PokemonController extends ChangeNotifier {
  final List<Pokemon> _pokemons = [];
  final NetworkService networkService = NetworkService();

  static const String JSONPokemonURL =
      "https://pokeapi.co/api/v2/pokemon/?limit=10";

  _fetchJSON() async {
    dynamic json = await networkService.fetchJSONFrom(url: JSONPokemonURL);
    List<dynamic> jsonPokemons = json["results"];

    for (int i = 0; i < jsonPokemons.length; i++) {
      var pokemon = jsonPokemons[i];
      _pokemons.add(Pokemon.fromJSON(pokemon));
    }
    // jsonPokemons.forEach((element) {
    //   _pokemon.add(Pokemon.fromJSON(element));
    // });
    notifyListeners();
  }

  PokemonController() {
    _fetchJSON();
  }

  int get numberOfPokemons {
    return _pokemons.length;
  }

  List<Pokemon> get pokemons {
    return _pokemons;
  }
}
