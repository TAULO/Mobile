import 'package:consumer/consumer.dart';
import 'package:flutter/material.dart';
import 'package:my_pokemon_app/controller/PokemonController.dart';
import 'Pokemon.dart';

class PokemonList extends StatelessWidget {
  const PokemonList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pokemons"),
      ),
      // body: Consumer<PokemonController>,
    );
  }

  PokemonRow(BuildContext context, Pokemon pokemon) {
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
          }),
    );
  }
}
