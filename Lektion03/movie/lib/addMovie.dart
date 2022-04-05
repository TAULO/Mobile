import 'package:flutter/material.dart';
import 'package:movie/addMovieForms.dart';

class addMovie extends StatelessWidget {
  const addMovie({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add a movie"),
      ),
      body: addMovieForm(),
    );
  }
}
