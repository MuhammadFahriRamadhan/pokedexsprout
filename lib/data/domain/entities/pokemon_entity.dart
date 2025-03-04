class PokemonEntity {
  String name;
  String url;

  PokemonEntity({
    required this.name,
    required this.url,
  });

  factory PokemonEntity.fromJson(Map<String, dynamic> json) => PokemonEntity(
    name: json["name"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "url": url,
  };
}