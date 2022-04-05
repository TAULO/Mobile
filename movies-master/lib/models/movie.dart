class Movie {
  String title, year, runtime, genre, director, actors, plot, country, awards, poster;
  bool favorite;

  Movie(this.favorite, this.title, this.year, this.runtime, this.genre, this.director, this.actors, this.plot, this.country, this.awards, this.poster);
  // Her anvender jeg en Named Construtor med en Initializer List.
  // Initializer listen udføres inden kroppen af constructoren,
  // og på den måde bliver attributter i klassen aldrig null,
  // hvilket de ikke må være i Dart.
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
        poster = json["poster"],
        favorite = false;

  Movie.fromJson(Map<String, dynamic> map)
      : title = map['title'] as String,
        year = map['year'] as String,
        runtime = map['runtime'] as String,
        genre = map["genre"] as String,
        director = map["director"] as String,
        actors = map["actors"] as String,
        plot = map["plot"] as String,
        country = map["country"] as String,
        awards = map["awards"] as String,
        poster = map["poster"] as String,
        favorite = map["favorite"] as bool; // TODO: What to do here?

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "year": year,
      "runtime": runtime,
      "genre": genre,
      "director": director,
      "actors": actors,
      "plot": plot,
      "country": country,
      "awards": awards,
      "poster": poster,
      "favorite": favorite,
    };
  }
}
