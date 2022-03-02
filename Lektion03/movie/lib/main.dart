import 'package:flutter/material.dart';
import 'package:movie/Detail.dart';
import 'movie_list.dart';

void main() {
  runApp(const Detail());
  // runApp(const Movies());
}

class Movies extends StatelessWidget {
  const Movies({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Movies",
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: const Detail(),
    );
  }
}
