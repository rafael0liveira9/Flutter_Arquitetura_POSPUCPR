class Movie {
  final String id;
  final String title;
  final String overview;
  final String? posterUrl;
  final double rating;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    this.posterUrl,
    required this.rating,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'].toString(),
      title: json['title'],
      overview: json['overview'],
      posterUrl: json['poster_path'] != null
          ? 'https://image.tmdb.org/t/p/w500' + json['poster_path']
          : json['posterUrl'] ?? '',
      rating: double.tryParse(json['vote_average']?.toString() ?? '') ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'overview': overview,
      'posterUrl': posterUrl,
      'rating': rating,
    };
  }
}
