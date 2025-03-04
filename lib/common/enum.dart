import 'dart:ui';

import '../presentation/themes/colors.dart';

enum ColorPokemon {
  grass('grass', AppColors.lightGreen),
  poison('poison', AppColors.lightPurple),
  fire('fire', AppColors.lightRed),
  flying('flying', AppColors.lilac),
  water('water', AppColors.lightBlue),
  bug('bug', AppColors.lightTeal),
  normal('normal', AppColors.beige),
  electric('electric', AppColors.lightYellow),
  ground('ground', AppColors.darkBrown),
  fairy('fairy', AppColors.pink),
  fighting('fighting', AppColors.red),
  psychic('psychic', AppColors.lightPink),
  rock('rock', AppColors.lightBrown),
  steel('steel', AppColors.grey),
  ice('ice', AppColors.lightCyan),
  ghost('ghost', AppColors.purple),
  dragon('dragon', AppColors.violet),
  dark('dark', AppColors.black),
  monster('monster', AppColors.lightBlue),
  unknown('unknown', AppColors.lightBlue);
  final String name;
  final Color color;

  const ColorPokemon(this.name, this.color);

  static ColorPokemon parse(String rawValue) => values.firstWhere(
        (e) => e.name == rawValue.toLowerCase(),
    orElse: () => unknown,
  );

  Map<ColorPokemon, double> get effectiveness => _pokemonEffectivenessMap[this] ?? {};
}

final _pokemonEffectivenessMap = <ColorPokemon, Map<ColorPokemon, double>>{
  ColorPokemon.normal: {
    ColorPokemon.ghost: 0,
    ColorPokemon.fighting: 2,
  },
  ColorPokemon.fire: {
    ColorPokemon.bug: 0.5,
    ColorPokemon.fairy: 0.5,
    ColorPokemon.fire: 0.5,
    ColorPokemon.grass: 0.5,
    ColorPokemon.ice: 0.5,
    ColorPokemon.steel: 0.5,
    ColorPokemon.ground: 2,
    ColorPokemon.rock: 2,
    ColorPokemon.water: 2,
  },
  ColorPokemon.water: {
    ColorPokemon.fire: 0.5,
    ColorPokemon.ice: 0.5,
    ColorPokemon.steel: 0.5,
    ColorPokemon.water: 0.5,
    ColorPokemon.electric: 2,
    ColorPokemon.grass: 2,
  },
  ColorPokemon.electric: {
    ColorPokemon.electric: 0.5,
    ColorPokemon.flying: 0.5,
    ColorPokemon.steel: 0.5,
    ColorPokemon.ground: 2,
  },
  ColorPokemon.grass: {
    ColorPokemon.electric: 0.5,
    ColorPokemon.grass: 0.5,
    ColorPokemon.ground: 0.5,
    ColorPokemon.water: 0.5,
    ColorPokemon.bug: 2,
    ColorPokemon.ice: 2,
    ColorPokemon.flying: 2,
    ColorPokemon.fire: 2,
    ColorPokemon.poison: 2,
  },
  ColorPokemon.ice: {
    ColorPokemon.ice: 0.5,
    ColorPokemon.fire: 2,
    ColorPokemon.fighting: 2,
    ColorPokemon.rock: 2,
    ColorPokemon.steel: 2,
  },
  ColorPokemon.fighting: {
    ColorPokemon.bug: 0.5,
    ColorPokemon.rock: 0.5,
    ColorPokemon.dark: 0.5,
    ColorPokemon.flying: 2,
    ColorPokemon.psychic: 2,
    ColorPokemon.fairy: 2,
  },
  ColorPokemon.poison: {
    ColorPokemon.fighting: 0.5,
    ColorPokemon.poison: 0.5,
    ColorPokemon.bug: 0.5,
    ColorPokemon.fairy: 0.5,
    ColorPokemon.ground: 2,
    ColorPokemon.psychic: 2,
  },
  ColorPokemon.ground: {
    ColorPokemon.electric: 0,
    ColorPokemon.poison: 0.5,
    ColorPokemon.rock: 0.5,
    ColorPokemon.water: 2,
    ColorPokemon.grass: 2,
    ColorPokemon.ice: 2,
  },
  ColorPokemon.flying: {
    ColorPokemon.ground: 0,
    ColorPokemon.grass: 0.5,
    ColorPokemon.fighting: 0.5,
    ColorPokemon.bug: 0.5,
    ColorPokemon.electric: 2,
    ColorPokemon.ice: 2,
    ColorPokemon.rock: 2,
  },
  ColorPokemon.psychic: {
    ColorPokemon.fighting: 0.5,
    ColorPokemon.psychic: 0.5,
    ColorPokemon.bug: 2,
    ColorPokemon.ghost: 2,
    ColorPokemon.dark: 2,
  },
  ColorPokemon.bug: {
    ColorPokemon.grass: 0.5,
    ColorPokemon.fighting: 0.5,
    ColorPokemon.ground: 0.5,
    ColorPokemon.fire: 2,
    ColorPokemon.flying: 2,
    ColorPokemon.rock: 2,
  },
  ColorPokemon.rock: {
    ColorPokemon.normal: 0.5,
    ColorPokemon.fire: 0.5,
    ColorPokemon.poison: 0.5,
    ColorPokemon.flying: 0.5,
    ColorPokemon.water: 2,
    ColorPokemon.grass: 2,
    ColorPokemon.fighting: 2,
    ColorPokemon.ground: 2,
    ColorPokemon.steel: 2,
  },
  ColorPokemon.ghost: {
    ColorPokemon.normal: 0,
    ColorPokemon.fighting: 0,
    ColorPokemon.poison: 0.5,
    ColorPokemon.bug: 0.5,
    ColorPokemon.ghost: 2,
    ColorPokemon.dark: 2,
  },
  ColorPokemon.dragon: {
    ColorPokemon.fire: 0.5,
    ColorPokemon.water: 0.5,
    ColorPokemon.electric: 0.5,
    ColorPokemon.grass: 0.5,
    ColorPokemon.ice: 2,
    ColorPokemon.dragon: 2,
    ColorPokemon.fairy: 2,
  },
  ColorPokemon.dark: {
    ColorPokemon.psychic: 0,
    ColorPokemon.ghost: 0.5,
    ColorPokemon.dark: 0.5,
    ColorPokemon.fighting: 2,
    ColorPokemon.bug: 2,
    ColorPokemon.fairy: 2,
  },
  ColorPokemon.steel: {
    ColorPokemon.poison: 0,
    ColorPokemon.normal: 0.5,
    ColorPokemon.grass: 0.5,
    ColorPokemon.ice: 0.5,
    ColorPokemon.flying: 0.5,
    ColorPokemon.psychic: 0.5,
    ColorPokemon.bug: 0.5,
    ColorPokemon.rock: 0.5,
    ColorPokemon.dragon: 0.5,
    ColorPokemon.steel: 0.5,
    ColorPokemon.fairy: 0.5,
    ColorPokemon.fire: 2,
    ColorPokemon.fighting: 2,
    ColorPokemon.ground: 2,
  },
  ColorPokemon.fairy: {
    ColorPokemon.dragon: 0,
    ColorPokemon.fighting: 0.5,
    ColorPokemon.bug: 0.5,
    ColorPokemon.dark: 0.5,
    ColorPokemon.poison: 2,
    ColorPokemon.steel: 2,
  },
};