part of '../pokemon_detail.dart';

class PokemonContentInfo extends StatefulWidget {
  PokemonInfoResponse pokemon;

  PokemonContentInfo({super.key,required this.pokemon});

  @override
  State<PokemonContentInfo> createState() => _PokemonContentInfoState();
}

class _PokemonContentInfoState extends State<PokemonContentInfo> with TickerProviderStateMixin {
  late PokemonInfoResponse pokemon;
  double textDiffLeft = 0.0;
  double textDiffTop = 0.0;
  late AnimationController _horizontalSlideController;

  final GlobalKey _currentTextKey = GlobalKey();
  final GlobalKey _targetTextKey = GlobalKey();
  AnimationController get slideController => PokemonDetailStateProvider.of(context).sliderAnimationController;
  AnimationController get rotateController => PokemonDetailStateProvider.of(context).rotateAnimationController;
  Animation<double> get textFadeAnimation => Tween(begin: 1.0, end: 0.0).animate(slideController);
  Animation<double> get sliderFadeAnimation => Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
    parent: slideController,
    curve: const Interval(0.0, 0.5, curve: Curves.ease),
  ));
  static const double _pokemonSliderViewportFraction = 0.56;
  static const int _endReachedThreshold = 4;

  @override
  void initState() {
    _horizontalSlideController = AnimationController(
      vsync: this,
      duration: const Duration(microseconds: 300),
    )..forward();

    pokemon = widget.pokemon;
    super.initState();
  }

  @override
  void dispose() {
    _horizontalSlideController.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        buildAppBar(),
        const SizedBox(height: 9,),
        buildPokemonName(),
        const SizedBox(height: 9),
        buildPokemonTypes(),
        const SizedBox(height: 25),
        buildPokemonImage()
      ],
    );
  }


  AppBar buildAppBar() {
    calculatePokemonNamePosition();
     return AppBar(
       foregroundColor: context.colors.textOnPrimary,
       title: Text(
         pokemon.name,
         key: _targetTextKey,
         style: const TextStyle(
           color: Colors.transparent,
           fontWeight: FontWeight.w900,
           fontSize: 22
         ),
       ),
       leading: IconButton(
         icon: Icon(Icons.arrow_back, color: Colors.white),
         onPressed: () => Navigator.of(context).pop(),
       ),
       actions: [
         IconButton(
           icon: Icon(Icons.favorite_border, color: Colors.white),
           onPressed: () {},
         ),
       ],
     );
  }

  Widget buildPokemonName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          AnimatedBuilder(
            animation: slideController,
            builder: (_, __) {
              final value = slideController.value;

              return Transform.translate(
                offset: Offset(textDiffLeft * value, textDiffTop * value),
                child: HeroText(
                    pokemon.name,
                    textKey: _currentTextKey,
                    style: TextStyle(
                      color: context.colors.textOnPrimary,
                      fontWeight: FontWeight.w900,
                      fontSize: 36 - (36 - 22) * value,
                    ),
                ),
              );
            },
          ),
          AnimatedSlider(
            animation: _horizontalSlideController,
            child: AnimatedFade(
              animation: textFadeAnimation,
              child: HeroText(
                '#00${pokemon.id}',
                style: TextStyle(
                  color: context.colors.textOnPrimary,
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                ),
              )
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPokemonTypes() {

    return AnimatedFade(
      animation: textFadeAnimation,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children:
                pokemon.types.take(3).map((type) => PokemonType(type.toType(), large: true)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPokemonImage() {
    final screenSize = MediaQuery.sizeOf(context);
    final sliderHeight = screenSize.height * 0.24;
    final pokeballSize = screenSize.height * 0.24;
    final pokemonSize = screenSize.height * 0.3;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return AnimatedFade(
      animation: sliderFadeAnimation,
      child: SizedBox(
        width: screenSize.width,
        height: sliderHeight,
        child: Stack(
          children:  <Widget>[
            Align(
              alignment: Alignment.bottomRight,
              child: RotationTransition(
                turns: rotateController,
                child: Image.asset(
                  'assets/images/pokeball.png',
                  width: pokeballSize,
                  height: pokeballSize,
                  color: context.colors.background.withOpacity(0.12),
                ),
              ),
            ),
            if (isPortrait)
            Align(
              alignment: Alignment.bottomCenter,
              child: Image.network(
                  pokemon.sprites.other!.officialArtwork.frontDefault
              )
            )
          ],
        )
      ) );

  }

  void calculatePokemonNamePosition() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final targetTextBox = _targetTextKey.currentContext?.findRenderObject() as RenderBox?;
      final currentTextBox = _currentTextKey.currentContext?.findRenderObject() as RenderBox?;

      if (targetTextBox == null || currentTextBox == null) return;

      final targetTextPosition = targetTextBox.localToGlobal(Offset.zero);
      final currentTextPosition = currentTextBox.localToGlobal(Offset.zero);

      final newDiffLeft = targetTextPosition.dx - currentTextPosition.dx;
      final newDiffTop = targetTextPosition.dy - currentTextPosition.dy;

      if (newDiffLeft != textDiffLeft || newDiffTop != textDiffTop) {
        setState(() {
          textDiffLeft = newDiffLeft;
          textDiffTop = newDiffTop;
        });
      }
    });
  }

}
