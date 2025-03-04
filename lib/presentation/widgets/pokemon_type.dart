import 'package:flutter/material.dart';
import 'package:pokedexsprout/common/extension.dart';

import '../../data/domain/entities/pokemon_info_entity.dart';

class PokemonType extends StatelessWidget {
  const PokemonType(
      this.type, {
        super.key,
        this.large = false,
        this.colored = false,
        this.extra = '',
      });

  final TypeEntity type;
  final String extra;
  final bool large;
  final bool colored;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: large ? 19 : 12,
          vertical: large ? 6 : 4,
        ),
        decoration: ShapeDecoration(
          shape: const StadiumBorder(),
          color: (colored ? type.color : context.colors.background).withOpacity(0.3),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              type.type.name,
              textScaler: TextScaler.noScaling,
              style: TextStyle(
                fontSize: large ? 12 : 8,
                height: 0.8,
                fontWeight: large ? FontWeight.bold : FontWeight.normal,
                color: colored ? type.color : context.colors.textOnPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(width: 5),
            Text(
              extra,
              textScaler: TextScaler.noScaling,
              style: TextStyle(
                fontSize: large ? 12 : 8,
                height: 0.8,
                fontWeight: large ? FontWeight.bold : FontWeight.normal,
                color: colored ? type.color : context.colors.textOnPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
