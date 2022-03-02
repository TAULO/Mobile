import 'package:flutter/material.dart';
import 'package:pokemon/Pokemon_Controller.dart';
import 'package:provider/provider.dart';

import 'Pokemon.dart';

class PokemonList extends StatelessWidget {
  const PokemonList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pokemons"),
      ),
      body: Consumer<PokemonController>(
          builder: (context, _pokemonController, widget) {
        return ListView.builder(
          itemCount: _pokemonController.numberOfPokemons,
          itemBuilder: (BuildContext context, int index) {
            final Pokemon pokemon = _pokemonController.pokemons[index];
            return pokemonRow(context, pokemon);
          },
        );
      }),
    );
  }
}

pokemonRow(BuildContext context, Pokemon pokemon) {
  final Future<String> pokemonImageURL = pokemon.fetchImageURL();
  return ListTile(
    leading: FutureBuilder(
      future: pokemonImageURL,
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          return Image(image: NetworkImage(snapshot.data as String));
        } else {
          return const Icon(Icons.image);
        }
      },
    ),
    title: Text(pokemon.name),
  );
}
