import 'package:flutter/material.dart';
import 'package:movies/widgets/add_movie_form.dart';

class AddMoviePage extends StatefulWidget {
  const AddMoviePage({Key? key}) : super(key: key);

  @override
  State<AddMoviePage> createState() => _AddMoviePageState();
}

class _AddMoviePageState extends State<AddMoviePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Add Movie"),
      ),
      body: const SingleChildScrollView(child: AddMovieForm()),
    );
  }
}
