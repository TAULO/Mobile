import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:movie/movie.dart';
import 'package:movie/movie_row.dart';

class MovieList extends StatefulWidget {
  MovieList({Key? key}) : super(key: key);

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  Future<List<Movie>> loadJSONData() async {
    List<Movie> movies = [];
    var jsonText = await rootBundle
        .loadString("assets/json/Movies.json"); //læs json fra fs
    List<dynamic> movieList = json.decode(jsonText);
    for (var element in movieList) {
      movies.add(Movie.fromJSON(element));
    }
    return movies;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movies"),
      ),
      body: FutureBuilder<List>(
          future: loadJSONData(),
          builder: (context, AsyncSnapshot<List> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Text("Der skete en fejl");
              } else if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return MovieRow(movie: snapshot.data?[index]);
                  },
                );
              } else {
                return const Text("Tom datasæt");
              }
            } else {
              return Text("State ${snapshot.connectionState}");
            }
          }),
    );
  }
}
