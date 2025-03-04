import 'dart:ui';

import 'enum.dart';

Color getPokemonColor(String type) {
  return ColorPokemon.values.firstWhere(
        (e) => e.name.toLowerCase() == type.toLowerCase(),
    orElse: () => ColorPokemon.unknown,
  ).color;
}

String formatHeight(int heightDm) {
  double heightMeters = heightDm / 10; // Convert to meters
  double heightFeet = heightMeters * 3.28084; // Convert to feet

  int feet = heightFeet.floor();
  double inchesDecimal = (heightFeet - feet) * 12;
  int inches = inchesDecimal.round();

  return "$feet'${inches}\" (${heightMeters.toStringAsFixed(2)} m)";
}

String formatWeight(int weightHg) {
  double weightKg = weightHg / 10; // Convert to kg
  double weightLbs = weightKg * 2.20462; // Convert to lbs

  return "${weightLbs.toStringAsFixed(1)} lbs (${weightKg.toStringAsFixed(1)} kg)";
}