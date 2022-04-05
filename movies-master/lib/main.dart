import 'package:flutter/material.dart';
import 'package:movies/pages/movie_page.dart';
import 'package:movies/state/app_state.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppState(),
      child: const MovieApp(),
    ),
  );
}

class MovieApp extends StatelessWidget {
  const MovieApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Movies",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MoviePage(),
    );
  }
}
