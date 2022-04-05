import 'package:flutter/material.dart';
import 'package:movies/pages/add_movie_page.dart';
import 'package:movies/widgets/movie_list.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({Key? key}) : super(key: key);

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movies"),
      ),
      body: const MovieList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddMoviePage()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
