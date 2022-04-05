import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:movies/models/Movie.dart';
import 'package:movies/services/file_service.dart';
import 'package:movies/services/network_service.dart';
import 'package:movies/services/shared_pref_service.dart';

class AppState extends ChangeNotifier {
  final SharedPrefService _sharedPrefService = SharedPrefService();
  final FileService _fileService = FileService();
  final List<Movie> _movies = [];

  List<Movie> get movies => _movies;

  AppState() {
    loadMovies();
    loadMoviesPathProvider();
  }

  void loadMovies() async {
    List<dynamic> jsonMovies = await NetworkService.loadJsonData(path: "assets/json/Movies.json");

    for (var jsonMovie in jsonMovies) {
      _movies.add(Movie.fromJSON(jsonMovie));
    }
    notifyListeners();
  }

  void loadMoviesPathProvider() async {
    for (var movie in await _fileService.readMovies()) {
      _movies.add(movie);
    }
    notifyListeners();
  }

  void loadMoviesSharedPref() async {
    for (var jsonMovie in await _sharedPrefService.get("movies")) {
      _movies.add(Movie.fromJSON(jsonMovie));
    }
    notifyListeners();
  }

  void addMoviePathProvider({required Movie movie}) async {
    _movies.add(movie);
    for (var movie in movies) {
      await _fileService.writeMovie(movie);
    }
    notifyListeners();
  }

  void addMovieSharedPref({required Movie movie}) async {
    _movies.add(movie);
    await _sharedPrefService.save("movies", jsonEncode(_movies));
    notifyListeners();
  }
}
