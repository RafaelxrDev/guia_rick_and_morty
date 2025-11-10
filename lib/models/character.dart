class Character {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final String originName;
  final String locationName;
  final String image;
  final List<String> episode;
  final String url;

  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.originName,
    required this.locationName,
    required this.image,
    required this.episode,
    required this.url,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: (json['id'] as num).toInt(),
      name: json['name'] ?? '',
      status: json['status'] ?? '',
      species: json['species'] ?? '',
      type: json['type'] ?? '',
      gender: json['gender'] ?? '',
      originName: (json['origin']?['name']) ?? '',
      locationName: (json['location']?['name']) ?? '',
      image: json['image'] ?? '',
      episode: (json['episode'] as List).map((e) => e.toString()).toList(),
      url: json['url'] ?? '',
    );
  }
}
