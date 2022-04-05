import 'package:shared_preferences/shared_preferences.dart';

class Movie {
  String title;
  String year;
  String runtime;
  String genre;
  String director;
  String actors;
  String plot;
  String country;
  String awards;
  String poster;

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

addStringToSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("name", "");
}

getStringValuesSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String value = prefs.getString("name") ?? "";
  return value;
}

removeValues() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove("name");
}
