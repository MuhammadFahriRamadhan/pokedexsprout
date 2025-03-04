import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class PositionedPokeball extends StatelessWidget {
  final double widthFraction;
  final double maxSize;

  const PositionedPokeball({
    super.key,
    this.widthFraction = 0.664,
    this.maxSize = 50,
  });

  @override
  Widget build(BuildContext context) {
    final iconSize = IconTheme.of(context).size ?? 0;
    final safeAreaTop = MediaQuery.paddingOf(context).top;
    final pokeballSize = min(MediaQuery.sizeOf(context).width * widthFraction, maxSize);
    final pokeballRightMargin = -(pokeballSize / 2 - 30  - iconSize / 2);
    final pokeballTopMargin = -(pokeballSize / 2 - safeAreaTop - kToolbarHeight );

    return Positioned(
      top: pokeballTopMargin,
      right: pokeballRightMargin,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            'assets/images/pokeball_seeklogo.png',
            width: pokeballSize,
            height: pokeballSize,
          ),
        ],
      )
    );
  }
}