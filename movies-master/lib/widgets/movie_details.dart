import 'package:flutter/material.dart';
import 'package:movies/models/Movie.dart';

class MovieDetails extends StatefulWidget {
  final Movie movie;
  const MovieDetails({required this.movie, Key? key}) : super(key: key);

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
              child: Text(
                widget.movie.title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 34),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(5.0, 5.0),
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                      ),
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        spreadRadius: 0.0,
                      ),
                    ],
                  ),
                  child: Image.asset(
                    "assets/images/${widget.movie.poster}.jpg",
                    width: 150,
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(top: 4, left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.movie.year}, ${widget.movie.country}",
                        ),
                        const SizedBox(height: 8),
                        Text(widget.movie.genre),
                        const SizedBox(height: 8),
                        Text(widget.movie.runtime),
                        const SizedBox(height: 8),
                        Text(widget.movie.awards),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  icon: widget.movie.favorite
                      ? const Icon(
                          Icons.favorite,
                          size: 32,
                        )
                      : const Icon(
                          Icons.favorite_border,
                          size: 32,
                        ),
                  color: Colors.red[500],
                  onPressed: () {
                    setState(() {
                      widget.movie.favorite = !widget.movie.favorite;
                    });
                  },
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      const Text(
                        "Director",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const SizedBox(height: 8),
                      Text(widget.movie.director),
                      const SizedBox(height: 8),
                      const Text(
                        "Actors",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const SizedBox(height: 8),
                      Text(widget.movie.actors),
                      const SizedBox(height: 8),
                      const Text(
                        "Summary",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const SizedBox(height: 8),
                      Text(widget.movie.plot),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
