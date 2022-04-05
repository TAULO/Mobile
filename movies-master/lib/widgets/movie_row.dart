import 'package:flutter/material.dart';
import 'package:movies/models/Movie.dart';
import 'package:movies/widgets/movie_details.dart';

class MovieRow extends StatefulWidget {
  final Movie movie;
  const MovieRow({Key? key, required this.movie}) : super(key: key);

  @override
  State<MovieRow> createState() => _MovieRowState();
}

class _MovieRowState extends State<MovieRow> {
  @override
  Widget build(BuildContext context) {
    _handleDetailedViewData() async {
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MovieDetails(movie: widget.movie)),
      );
      setState(() {});
    }

    return InkWell(
      onTap: () => _handleDetailedViewData(),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Row(
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
                width: 110,
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.movie.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(widget.movie.genre),
                    Text(widget.movie.runtime),
                  ],
                ),
              ),
            ),
            widget.movie.favorite
                ? const Icon(
                    Icons.favorite,
                    size: 32,
                    color: Colors.red,
                  )
                : const Icon(
                    Icons.favorite_border,
                    size: 32,
                    color: Colors.red,
                  ),
          ],
        ),
      ),
    );
  }
}

  /* @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        "assets/images/${movie.poster}.jpg",
        width: 110,
      ),
      title: Text(movie.title),
      subtitle: Text(movie.genre),
      trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.star)),
    );
  } */