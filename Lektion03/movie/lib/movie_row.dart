import 'package:flutter/material.dart';

import 'movie.dart';

class MovieRow extends StatelessWidget {
  final Movie movie;
  const MovieRow({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // dette er den nemme måde:
    // return ListTile(
    //   leading: Image.asset(
    //     "assets/images/${movie.poster}.jpg",
    //     width: 110,
    //   ),
    //   title: Text(movie.title),
    //   subtitle: Text(movie.plot),
    //   trailing: IconButton(
    //     onPressed: () => {},
    //     icon: const Icon(Icons.info),
    //   ),
    // );
    return Container(
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
                    spreadRadius: 2.0),
                BoxShadow(
                    color: Colors.white,
                    offset: Offset(0.0, 0.0),
                    blurRadius: 0.0,
                    spreadRadius: 0.0),
              ],
            ),
            child: Image.asset("assets/images/${movie.poster}.jpg"),
          ),
          Expanded(
              child: Container(
            padding: const EdgeInsets.only(left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  movie.genre,
                ),
                Text(movie.runtime)
              ],
            ),
          )),
          Icon(Icons.star, color: Colors.red[500]),
        ],
      ),
    );
  }
}
