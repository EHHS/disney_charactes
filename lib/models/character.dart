class Character {
  Character({
    required this.id,
    required this.name,
    this.imageUrl,
    this.films,
    this.shortFilms,
    this.tvShows,
    this.videoGames,
    this.parkAttractions,
    this.allies,
    this.enemies,
    this.sourceUrl,
    this.createdAt,
    this.updatedAt,
    this.url,
  });

  final int id;
  final String name;
  final String? imageUrl;
  final List<String>? films;
  final List<String>? shortFilms;
  final List<String>? tvShows;
  final List<String>? videoGames;
  final List<String>? parkAttractions;
  final List<String>? allies;
  final List<String>? enemies;
  final String? sourceUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? url;

  factory Character.fromJson(Map<String, dynamic> json) => Character(
        id: json['_id'],
        films: json['films'] != null ? List<String>.from(json['films']) : null,
        shortFilms: json['shortFilms'] != null
            ? List<String>.from(json['shortFilms'])
            : null,
        tvShows:
            json['tvShows'] != null ? List<String>.from(json['tvShows']) : null,
        videoGames: json['videoGames'] != null
            ? List<String>.from(json['videoGames'])
            : null,
        parkAttractions: json['parkAttractions'] != null
            ? List<String>.from(json['parkAttractions'])
            : null,
        allies:
            json['allies'] != null ? List<String>.from(json['allies']) : null,
        enemies:
            json['enemies'] != null ? List<String>.from(json['enemies']) : null,
        sourceUrl: json['sourceUrl'],
        name: json['name'],
        imageUrl: json['imageUrl'],
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : null,
        updatedAt: json['updatedAt'] != null
            ? DateTime.parse(json['updatedAt'])
            : null,
        url: json['url'],
      );
}
