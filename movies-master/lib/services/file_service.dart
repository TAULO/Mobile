import 'dart:convert';
import 'dart:io';

import 'package:movies/models/Movie.dart';
import 'package:path_provider/path_provider.dart';

class FileService {
  static File? _file;
  static const _fileName = "movies.txt";
  static final Set<Movie> _movieSet = {};

  // TODO: Sprøg Kaj om getters/setters?
  Future<File> get file async {
    if (_file != null) {
      return _file!;
    }
    _file = await _initFile();
    return _file!;
  }

  Future<File> _initFile() async {
    final _directory = await getApplicationDocumentsDirectory();
    final _path = _directory.path;
    return File('$_path/$_fileName').create();
  }

  Future<void> writeMovie(Movie movie) async {
    final File currentFile = await file;
    _movieSet.add(movie);

    // Now convert the set to a list as the jsonEncoder cannot encode
    // a set but a list.
    final _movieListMap = _movieSet.map((m) => m.toJson()).toList();
    await currentFile.writeAsString(jsonEncode(_movieListMap));
  }

  Future<List<Movie>> readMovies() async {
    final File currentFile = await file;
    final _content = await currentFile.readAsString();
    List<Movie> _movies = [];

    if (_content.isNotEmpty) {
      final List<dynamic> _jsonData = jsonDecode(_content);
      _movies = _jsonData
          .map(
            (m) => Movie.fromJson(m as Map<String, dynamic>),
          )
          .toList();
    }

    return _movies;
  }

  Future<void> deleteMovie(Movie movie) async {
    final File currentFile = await file;
    _movieSet.removeWhere((m) => m == movie);
    final _movieListMap = _movieSet.map((m) => m.toJson()).toList();
    await currentFile.writeAsString(jsonEncode(_movieListMap));
  }

  Future<void> updateMovie({
    required int id,
    required Movie movie,
  }) async {
    _movieSet.removeWhere((m) => m.title == movie.title);
    await writeMovie(movie);
  }
}
