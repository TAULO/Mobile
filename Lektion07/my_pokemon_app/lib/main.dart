import 'package:flutter/material.dart';
import 'package:my_pokemon_app/model/Pokemon.dart';

import 'model/PokemonList.dart';

void main() {
  runApp(const Pokemons());
}

class Pokemons extends StatelessWidget {
  const Pokemons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "PokemonApp",
      theme: ThemeData(primaryColor: Colors.red),
      home: const PokemonList(),
    );
  }
}
