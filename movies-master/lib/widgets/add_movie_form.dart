import 'package:flutter/material.dart';
import 'package:movies/models/Movie.dart';
import 'package:movies/state/app_state.dart';
import 'package:provider/provider.dart';

class AddMovieForm extends StatefulWidget {
  const AddMovieForm({Key? key}) : super(key: key);

  @override
  State<AddMovieForm> createState() => _AddMovieFormState();
}

class _AddMovieFormState extends State<AddMovieForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _favorite = false;

  Movie movie = Movie(false, "title", "year", "runtime", "genre", "director",
      "actors", "plot", "country", "awards", "Inception");

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                hintText: "Enter a title",
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title.';
                }
                return null;
              },
              onSaved: (value) => {
                if (value != null) {movie.title = value}
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: "Enter a year",
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a year.';
                }
                return null;
              },
              onSaved: (value) => {
                if (value != null) {movie.year = value}
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: "Enter a runtime",
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a runtime.';
                }
                return null;
              },
              onSaved: (value) => {
                if (value != null) {movie.runtime = value}
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: "Enter a genre",
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a genre.';
                }
                return null;
              },
              onSaved: (value) => {
                if (value != null) {movie.genre = value}
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: "Enter a director name",
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a director name.';
                }
                return null;
              },
              onSaved: (value) => {
                if (value != null) {movie.director = value}
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: "Enter actor names",
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter actor names.';
                }
                return null;
              },
              onSaved: (value) => {
                if (value != null) {movie.actors = value}
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: "Enter a plot",
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a plot';
                }
                return null;
              },
              onSaved: (value) => {
                if (value != null) {movie.plot = value}
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: "Enter a country",
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a country';
                }
                return null;
              },
              onSaved: (value) => {
                if (value != null) {movie.country = value}
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: "Enter awards",
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter awards';
                }
                return null;
              },
              onSaved: (value) => {
                if (value != null) {movie.awards = value}
              },
            ),
            // Gør ikke noget endnu
            SwitchListTile(
              title: const Text('Favorite'),
              value: _favorite,
              onChanged: (bool value) {
                setState(() {
                  _favorite = value;
                });
              },
              secondary: const Icon(Icons.favorite),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () async {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  final form = _formKey.currentState;
                  if (form!.validate()) {
                    form.save();
                    Provider.of<AppState>(context, listen: false)
                        .addMoviePathProvider(movie: movie);
                    Navigator.pop(context);
                  }
                },
                child: const Text("Add"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
