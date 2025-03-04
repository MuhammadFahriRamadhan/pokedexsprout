import 'dart:ui';

import 'enum.dart';

Color getPokemonColor(String type) {
  return ColorPokemon.values.firstWhere(
        (e) => e.name.toLowerCase() == type.toLowerCase(),
    orElse: () => ColorPokemon.unknown,
  ).color;
}