import 'package:flutter/material.dart';
import 'package:movies/state/app_state.dart';
import 'package:movies/widgets/movie_row.dart';
import 'package:provider/provider.dart';

class MovieList extends StatefulWidget {
  const MovieList({Key? key}) : super(key: key);

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, state, child) {
        return ListView.builder(
          itemCount: state.movies.length,
          itemBuilder: (context, index) {
            return MovieRow(movie: state.movies[index]);
          },
        );
      },
    );
  }
}
