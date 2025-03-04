part of'../pokemon_detail.dart';

class PokemonDetailCard extends StatefulWidget {
  static const double minCardHeightFraction = 0.54;
  PokemonInfoResponse pokemon;
  PokemonSpeciesResponse pokemonSpecies;

  PokemonDetailCard({super.key,required this.pokemon,required this.pokemonSpecies});

  @override
  State<PokemonDetailCard> createState() => _PokemonDetailCardState();
}

class _PokemonDetailCardState extends State<PokemonDetailCard> {
  AnimationController get sliderAnimationController => PokemonDetailStateProvider.of(context).sliderAnimationController;
  late PokemonInfoResponse pokemon;
  late PokemonSpeciesResponse pokemonSpecies;

  @override
  void initState() {
    pokemon = widget.pokemon;
    pokemonSpecies = widget.pokemonSpecies;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final safeArea = MediaQuery.paddingOf(context);
    final appBarHeight = AppBar().preferredSize.height;

    final cardMinHeight = screenHeight * PokemonDetailCard.minCardHeightFraction;
    final cardMaxHeight = screenHeight - appBarHeight - safeArea.top;
    return AutoSlideUpPanel(
      minHeight: cardMinHeight,
      maxHeight: cardMaxHeight,
      onPanelSlide: (position) => sliderAnimationController.value = position,
      child: MainTabView(
          paddingAnimation: sliderAnimationController,
          tabs: [
            MainTabData(label: 'About', child: PokemonAbout(pokemon,pokemonSpecies)),
            MainTabData(label: 'Base Stats', child: PokemonBaseStats(pokemon)),
            const MainTabData(
              label: 'Evolution',
              child: Align(
                alignment: Alignment.topCenter,
                child: Text('Under development'),
              ),
            ),
            const MainTabData(
              label: 'Moves',
              child: Align(
                alignment: Alignment.topCenter,
                child: Text('Under development'),
              ),
            ),
          ]
      ) ,
    );
  }
}
