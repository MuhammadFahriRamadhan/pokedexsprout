import 'dart:ui';

class PokemonInfoEntity {
  String name;
  Color color;
  String? imageUrl;
  List<TypeEntity> types;
  int id;

  PokemonInfoEntity({
    required this.name,
    required this.color,
    required this.imageUrl,
    required this.types,
    required this.id
  });

  factory PokemonInfoEntity.fromJson(Map<String, dynamic> json) => PokemonInfoEntity(
    name: json["name"],
    color: json["color"],
    imageUrl: json["imageUrl"],
    types : List<TypeEntity>.from(json["types"].map((x) => TypeEntity.fromJson(x))),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "types": types,
  };
}

class TypeEntity {
  int slot;
  SpeciesEntity type;
  Color color;


  TypeEntity({
    required this.slot,
    required this.color,
    required this.type,
  });

  factory TypeEntity.fromJson(Map<String, dynamic> json) => TypeEntity(
    slot: json["slot"],
    color: json["color"],
    type: SpeciesEntity.fromJson(json["type"]),
  );

  Map<String, dynamic> toJson() => {
    "slot": slot,
    "type": type.toJson(),
  };
}

class SpeciesEntity {
  String name;
  String url;

  SpeciesEntity({
    required this.name,
    required this.url,
  });

  factory SpeciesEntity.fromJson(Map<String, dynamic> json) => SpeciesEntity(
    name: json["name"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "url": url,
  };
}
