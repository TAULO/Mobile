import 'package:flutter/material.dart';

import 'movie.dart';

class addMovieForm extends StatefulWidget {
  addMovieForm({Key? key}) : super(key: key);

  @override
  State<addMovieForm> createState() => _addMovieFormState();
}

class _addMovieFormState extends State<addMovieForm> {
  Movie newMovie = Movie("", "", "", "", "", "", "", "", "", "");

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextFormField(
            key: _formKey,
            decoration: const InputDecoration(hintText: "Title of movie"),
            textAlign: TextAlign.center,
            onSaved: (value) => setState(() {
              newMovie.title = value.toString();
            }),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "adad";
              }
              return null;
            },
          ),
          TextFormField(
            // key: _formKey,
            decoration: const InputDecoration(hintText: "Release date"),
            textAlign: TextAlign.center,
            onSaved: (value) => setState(() {
              String formattedReleasedDate = "";
              newMovie.year = value.toString();
            }),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "adad";
              }
              return null;
            },
          ),
          TextFormField(
            // key: _formKey,
            decoration: const InputDecoration(hintText: "Movie runtime"),
            textAlign: TextAlign.center,
            onSaved: (value) => setState(() {
              newMovie.runtime = value.toString();
            }),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "adad";
              }
              return null;
            },
          ),
          TextFormField(
            // key: _formKey,
            decoration: const InputDecoration(hintText: "Movie genre"),
            textAlign: TextAlign.center,
            onSaved: (value) => setState(() {
              newMovie.genre = value.toString();
            }),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "adad";
              }
              return null;
            },
          ),
          TextFormField(
            // key: _formKey,
            decoration: const InputDecoration(hintText: "Movie director"),
            textAlign: TextAlign.center,
            onSaved: (value) => setState(() {
              newMovie.director = value.toString();
            }),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "adad";
              }
              return null;
            },
          ),
          TextFormField(
            // key: _formKey,
            decoration: const InputDecoration(hintText: "Movie actors"),
            textAlign: TextAlign.center,
            onSaved: (value) => setState(() {
              newMovie.actors = value.toString();
            }),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "adad";
              }
              return null;
            },
          ),
          TextFormField(
            // key: _formKey,
            decoration: const InputDecoration(hintText: "Movie plot"),
            textAlign: TextAlign.center,
            onSaved: (value) => setState(() {
              newMovie.plot = value.toString();
            }),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "adad";
              }
              return null;
            },
          ),
          TextFormField(
            // key: _formKey,
            decoration: const InputDecoration(hintText: "Movie country"),
            textAlign: TextAlign.center,
            onSaved: (value) => setState(() {
              newMovie.country = value.toString();
            }),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "adad";
              }
              return null;
            },
          ),
          TextFormField(
            // key: _formKey,
            decoration: const InputDecoration(hintText: "Movie awards"),
            textAlign: TextAlign.center,
            onSaved: (value) => setState(() {
              newMovie.awards = value.toString();
            }),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "adad";
              }
              return null;
            },
          ),
          TextFormField(
            // key: _formKey,
            decoration: const InputDecoration(hintText: "Movie poster"),
            textAlign: TextAlign.center,
            onSaved: (value) => setState(() {
              newMovie.poster = value.toString();
            }),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "adad";
              }
              return null;
            },
          ),
          TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  return;
                }
                _formKey.currentState!.save();
              },
              child: const Text("Add movie!")),
        ],
      ),
    );
  }
}
