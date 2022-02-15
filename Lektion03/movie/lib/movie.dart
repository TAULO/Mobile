class Movie {
  final String title;
  final String year;
  final String runtime;
  final String genre;
  final String director;
  final String actors;
  final String plot;
  final String country;
  final String awards;
  final String poster;

  Movie(this.title, this.year, this.runtime, this.genre, this.director,
      this.actors, this.plot, this.country, this.awards, this.poster);

  Movie.fromJSON(Map<String, dynamic> json)
      : title = json["title"],
        year = json["year"],
        runtime = json["runtime"],
        genre = json["genre"],
        director = json["director"],
        actors = json["actors"],
        plot = json["plot"],
        country = json["country"],
        awards = json["awards"],
        poster = json["poster"];
}
