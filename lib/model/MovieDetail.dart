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
