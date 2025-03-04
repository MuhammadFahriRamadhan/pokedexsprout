

import 'package:flutter/material.dart';

class PokemonDetailStateProvider extends InheritedWidget {
  final AnimationController sliderAnimationController;
  final AnimationController rotateAnimationController;

  PokemonDetailStateProvider({
    super.key,
    required this.sliderAnimationController,
    required this.rotateAnimationController,
    required super.child});

  static PokemonDetailStateProvider of(BuildContext context){
    final result = context.dependOnInheritedWidgetOfExactType<PokemonDetailStateProvider>();

    return result!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget)  => false;

}