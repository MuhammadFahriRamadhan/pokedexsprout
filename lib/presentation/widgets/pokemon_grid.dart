import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedexsprout/common/extension.dart';
import 'package:pokedexsprout/data/domain/entities/pokemon_entity.dart';
import 'package:pokedexsprout/data/domain/entities/pokemon_info_entity.dart';
import 'package:pokedexsprout/presentation/pages/pokemon_detail/pokemon_detail.dart';
import 'package:pokedexsprout/presentation/widgets/pokemon_image.dart';
import 'package:pokedexsprout/presentation/widgets/pokemon_type.dart';

class PokemonGrid extends StatelessWidget {
  final List<PokemonInfoEntity> pokemons;

  const PokemonGrid({Key? key, required this.pokemons}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      delegate: SliverChildBuilderDelegate(
            (_, index) {
            return PokemonCard(
              pokemons[index],
              onPress: () =>{
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PokemonDetailPage( id:  pokemons[index].id.toString()),
                ))
              },
            );
        },
        childCount: pokemons.length,
      ),
    );
  }
}



class PokemonCard extends StatelessWidget {
  static const double _pokeballFraction = 0.75;
  static const double _pokemonFraction = 0.76;

  final PokemonInfoEntity pokemon;
  final void Function()? onPress;

  const PokemonCard(
      this.pokemon, {
        super.key,
        this.onPress,
      });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        final itemHeight = constrains.maxHeight;

        return Container(
          decoration: BoxDecoration(
            color: pokemon.color,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: pokemon.color.withOpacity(0.4),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Material(
              color: pokemon.color,
              child: InkWell(
                onTap: onPress,
                splashColor: Colors.white10,
                highlightColor: Colors.white10,
                child: Stack(
                  children: [
                    _buildPokeballDecoration(height: itemHeight),
                    _buildPokemon(height: itemHeight),
                    _buildPokemonNumber(),
                    _CardContent(pokemon),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPokeballDecoration({required double height}) {
    final pokeballSize = height * _pokeballFraction;

    return Positioned(
      bottom: -height * 0.13,
      right: -height * 0.03,
      child: Image.asset(
        'assets/images/pokeball.png',
        width: pokeballSize,
        height: pokeballSize,
        color: Colors.white.withOpacity(0.14),
      ),
    );
  }

  Widget _buildPokemon({required double height}) {
    final pokemonSize = height * _pokemonFraction;

    return Positioned(
      bottom: -2,
      right: 2,
      child: PokemonImage(
        size: Size.square(pokemonSize),
        pokemon: pokemon,
      ),
    );
  }

  Widget _buildPokemonNumber() {
    return Positioned(
      top: 10,
      right: 14,
      child: Text(
        '#00${pokemon.id}',
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white70,
        ),
      ),
    );
  }
}

class _CardContent extends StatelessWidget {
  final PokemonInfoEntity pokemon;

  const _CardContent(this.pokemon);

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: context.typographies.bodySmall.copyWith(
        color: context.colors.textOnPrimary,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Hero(
                tag: pokemon.id.toString() + pokemon.name,
                child: Text(
                  pokemon.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              ..._buildTypes(context),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTypes(BuildContext context) {
    return pokemon.types
        .take(2)
        .map(
          (type) => Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: PokemonType(type),
      ),
    )
        .toList();
  }
}



