part of '../pokemon_detail.dart';

class _Label extends StatelessWidget {
  final String text;

  const _Label(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
        height: 0.8,
      ),
    );
  }
}

class _ContentSection extends StatelessWidget {
  final String label;
  final List<Widget>? children;

  const _ContentSection({
    required this.label,
    this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(height: 0.8, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 22),
        if (children != null) ...children!
      ],
    );
  }
}
class _ContentWithoutLabel extends StatelessWidget {
  final List<Widget>? children;

  const _ContentWithoutLabel({
    this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 22),
        if (children != null) ...children!
      ],
    );
  }
}

class _TextIcon extends StatelessWidget {
  final String icon;
  final String text;

  const _TextIcon(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(icon, width: 12, height: 12),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(height: 0.8)),
      ],
    );
  }
}

class PokemonAbout extends StatelessWidget {
  final PokemonInfoResponse pokemon;
  final PokemonSpeciesResponse pokemonSpecies;

  const PokemonAbout(this.pokemon,this.pokemonSpecies);

  @override
  Widget build(BuildContext context) {
    final slideController = PokemonDetailStateProvider.of(context).sliderAnimationController;

    return AnimatedBuilder(
      animation: slideController,
      builder: (context, child) {
        final scrollable = slideController.value.floor() == 1;

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 19, horizontal: 27),
          physics:
          scrollable ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
          child: child,
        );
      },
      child: Column(
        children: <Widget>[
          _buildDescription(pokemon),
          const SizedBox(height: 28),
          _buildBreeding(pokemonSpecies)
        ],
      ),
    );
  }

  Widget _buildDescription(PokemonInfoResponse pokemon) {
    return _ContentWithoutLabel(
      children: [
        Row(
          children: <Widget>[
            const Expanded(child: _Label('Species')),
            Expanded(
              flex: 2,
              child: Text(pokemon.species.name, style: const TextStyle(height: 0.8)),
            ),
            const Expanded(flex: 1, child: SizedBox()),
          ],
        ),
        const SizedBox(height: 18),
        Row(
          children: <Widget>[
            const Expanded(child: _Label('Height')),
            Expanded(
              flex: 2,
              child: Text(pokemon.height.toString(), style: const TextStyle(height: 0.8)),
            ),
            const Expanded(flex: 1, child: SizedBox()),
          ],
        ),
        const SizedBox(height: 18),
        Row(
          children: <Widget>[
            const Expanded(child: _Label('Weight')),
            Expanded(
              flex: 2,
              child: Text(pokemon.weight.toString(), style: const TextStyle(height: 0.8)),
            ),
            const Expanded(flex: 1, child: SizedBox()),
          ],
        ),
        const SizedBox(height: 18),
        Row(
          children: <Widget>[
            const Expanded(child: _Label('Abilities')),
            Expanded(
              flex: 2,
              child: Text(pokemon.abilities.map((e) => e.ability.name).join(', '), style: const TextStyle(height: 0.8)),
            ),
            const Expanded(flex: 1, child: SizedBox()),
          ],
        ),
        const SizedBox(height: 18),
      ],
    );
  }

  Widget _buildBreeding(PokemonSpeciesResponse pokemon) {
    return _ContentSection(
      label: 'Breeding',
      children: [
        Row(
          children: <Widget>[
              _Label('Gender'),
             SizedBox(width: 35),
             getGenderValue(pokemon.genderRate),
            ],
        ),
        const SizedBox(height: 18),
        Row(
          children: <Widget>[
            const Expanded(child: _Label('Egg Groups')),
            Expanded(
              flex: 2,
              child: Text( pokemon.eggGroups.map((e) => e.name).join(', '), style: const TextStyle(height: 0.8)),
            ),
            const Expanded(flex: 1, child: SizedBox()),
          ],
        ),
        const SizedBox(height: 18),
        Row(
          children: <Widget>[
            const Expanded(child: _Label('Egg Cycles')),
            Expanded(
              flex: 2,
              child: Text( pokemon.eggGroups.map((e) => e.name).join(', '), style: const TextStyle(height: 0.8)),
            ),
            const Expanded(flex: 1, child: SizedBox()),
          ],
        ),
      ],
    );
  }



  Widget getGenderValue(int genderRate) {
    if (genderRate == -1) {
      return _TextIcon('assets/images/genderless.png', 'Genderless');
    } else if (genderRate == 0) {
      return Row(
        children: [
          _TextIcon('assets/images/male.png', '100%'),
          SizedBox(width: 8),
          _TextIcon('assets/images/female.png', '0%'),
        ],
      );
    } else if (genderRate == 8) {
      return Row(
        children: [
          _TextIcon('assets/images/male.png', '0%'),
          SizedBox(width: 8),
          _TextIcon('assets/images/female.png', '100%'),
        ],
      );
    } else {
      double malePercentage = (8 - genderRate) / 8 * 100;
      double femalePercentage = (genderRate) / 8 * 100;
      return Row(
        children: [
          _TextIcon('assets/images/male.png', '${malePercentage.toInt()}%'),
          SizedBox(width: 8),
          _TextIcon('assets/images/female.png', '${femalePercentage.toInt()}%'),
        ],
      );
    }
  }
}
