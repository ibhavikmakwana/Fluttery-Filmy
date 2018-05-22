class MovieDetail {
  var id;
  final String originalTitle;
  final List<String> genres;
  final String synopsis;
  final String posterPath;
  final String backdropPath;
  double voteAverage;
  final List<ProductionCompanies> productionCompanies;

  MovieDetail(
      this.id,
      this.originalTitle,
      this.genres,
      this.synopsis,
      this.posterPath,
      this.backdropPath,
      this.voteAverage,
      this.productionCompanies);

//  factory MovieDetail.fromJson(Map<String, dynamic> json) {
//    return new MovieDetail(
//      id: json["id"],
//      originalTitle: json["original_title"],
//      genres: json["genres"],
//      synopsis: json["overview"],
//      posterPath: json["poster_path"],
//      backdropPath: json["backdrop_path"],
//      voteAverage: json["vote_average"],
//      productionCompanies: json["production_companies"],
//    );
//  }
}

class Genres {
  var id;
  final String name;

  Genres(this.id, this.name);
}

class ProductionCompanies {
  var id;
  final String name;
  final String logoPath;

  ProductionCompanies(this.id, this.name, this.logoPath);
}
