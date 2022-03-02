import 'package:flutter/material.dart';
import 'PokemonList.dart';
import 'Pokemon_Controller.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => PokemonController(),
    child: const Pokemons(),
  ));
}

class Pokemons extends StatelessWidget {
  const Pokemons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Pokemons",
      theme: ThemeData(primarySwatch: Colors.red),
      home: const PokemonList(),
    );
  }
}
