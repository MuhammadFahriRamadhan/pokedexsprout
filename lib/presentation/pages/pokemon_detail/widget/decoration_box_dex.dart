part of '../pokemon_detail.dart';

class DecorationBoxDex extends StatelessWidget {
  static const Size size = Size.square(144);

  const DecorationBoxDex({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
        angle: pi * 5 / 12,
        alignment: Alignment.center,
        child: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
                colors: [Colors.white.withOpacity(0.3),Colors.white.withOpacity(0)],
                begin: const Alignment(-0.2, -0.2),
                end: const Alignment(1.5, -0.3),
            )
          ),
        ) ,
    );
  }
}

class DottedDecoration extends StatelessWidget {
  static const Size size = Size(57, 31);

  final Animation<double> animation;
  const DottedDecoration({ required this.animation });

  @override
  Widget build(BuildContext context) {
    return AnimatedFade(
      animation: animation,
      child: Image.asset(
          "assets/images/dotted.png",
          width: size.width,
          height: size.height,
          color: Colors.white30,
      ),
    );
  }
}


class BackgroundDecoration extends StatefulWidget {
  PokemonInfoResponse pokemon;

  BackgroundDecoration({super.key,required this.pokemon});

  @override
  State<BackgroundDecoration> createState() => _BackgroundDecorationState();
}

class _BackgroundDecorationState extends State<BackgroundDecoration> {
  Animation<double> get slideAnimationController => PokemonDetailStateProvider.of(context).sliderAnimationController;
  Animation<double> get rotateAnimationController => PokemonDetailStateProvider.of(context).rotateAnimationController;
  late PokemonInfoResponse pokemon;

  @override
  void initState() {
    pokemon = widget.pokemon;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        buildBackground(),
        buildDecorationBoxDex(),
        buildDottedDecoration(),
        buildAppBarPokeballDecoration()
      ],
    );
  }

  Widget buildDecorationBoxDex() {
    return Positioned(
      top: -DecorationBoxDex.size.height * 0.4,
      left: -DecorationBoxDex.size.width * 0.4,
      child: const DecorationBoxDex(),
    );
  }


  Widget buildBackground(){
    return  AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      constraints: const BoxConstraints.expand(),
      color: getPokemonColor(pokemon.types.first.type.name),
    );
  }

  Widget buildDottedDecoration() {
    return Positioned(
        top: 4,
        right: 72,
        child: DottedDecoration(animation: slideAnimationController)
    );
  }

  Widget buildAppBarPokeballDecoration() {
    final screenSize = MediaQuery.sizeOf(context);
    final safeAreaTop = MediaQuery.paddingOf(context).top;

    final pokeSize = screenSize.width * 0.5;
    final appBarHeight = AppBar().preferredSize.height;
    final iconButtonPadding = 20;
    final iconSize = IconTheme.of(context).size ?? 0;

    final pokeballTopMargin = -(pokeSize / 2 - safeAreaTop - appBarHeight / 2);
    final pokeballRightMargin = -(pokeSize / 2 - iconButtonPadding - iconSize / 2);

    return Positioned(
      top: pokeballTopMargin,
      right: pokeballRightMargin,
      child: IgnorePointer(
        ignoring: true,
        child: AnimatedFade(
          animation: slideAnimationController,
          child: RotationTransition(
            turns: rotateAnimationController,
            child: Image.asset(
              'assets/images/pokeball.png',
              width: pokeSize,
              height: pokeSize,
              color: Colors.white24,
            ),
          ),
        ),
      ),
    );
  }
}

