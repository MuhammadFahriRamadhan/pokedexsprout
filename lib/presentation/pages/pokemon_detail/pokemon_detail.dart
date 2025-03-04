import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedexsprout/common/animated_fade.dart';
import 'package:pokedexsprout/common/enum.dart';
import 'package:pokedexsprout/common/ext.dart';
import 'package:pokedexsprout/common/extension.dart';
import 'package:pokedexsprout/data/domain/entities/pokemon_info_entity.dart';
import 'package:pokedexsprout/data/domain/model/pokemon_info_response.dart';
import 'package:pokedexsprout/data/domain/model/pokemon_species_reponse.dart';
import 'package:pokedexsprout/presentation/pages/pokemon_detail/pokemon_detail_state_provider.dart';
import 'package:pokedexsprout/presentation/themes/colors.dart';
import 'package:pokedexsprout/presentation/widgets/auto_slideup_panel.dart';
import 'package:pokedexsprout/presentation/widgets/hero.dart';
import 'package:pokedexsprout/presentation/widgets/main_tab_view.dart';

import '../../../common/string.dart';
import '../../provider/pokemon_provider.dart';
import '../../widgets/animated_slide.dart';
import '../../widgets/pokemon_image.dart';
import '../../widgets/pokemon_type.dart';
import '../../widgets/progress.dart';


part 'widget/decoration_box_dex.dart';
part 'widget/pokemon_detail_card.dart';
part 'widget/pokemon_detail_about.dart';
part 'widget/pokemon_detail_card_basestats.dart';
part 'widget/pokemon_content_info.dart';

class PokemonDetailPage extends StatefulWidget {
  final String? id;
  const PokemonDetailPage({super.key,this.id});

  @override
  State<PokemonDetailPage> createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends State<PokemonDetailPage> with TickerProviderStateMixin {
  late AnimationController sliderAnimatedController;
  late AnimationController rotateAnimatedController;
  late String id;

@override
  void initState() {
    sliderAnimatedController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300)
    );

    rotateAnimatedController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 5000)
    )..repeat();

    id = widget.id.toString();
    super.initState();
  }

  @override
  void dispose() {
     sliderAnimatedController.dispose();
     rotateAnimatedController.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return PokemonDetailStateProvider(
        sliderAnimationController: sliderAnimatedController,
        rotateAnimationController: rotateAnimatedController,
        child: Scaffold(
          body: PokemonDetailConsumer(id)
        ));
  }
}

class PokemonDetailConsumer extends ConsumerWidget {
    final String id;

    PokemonDetailConsumer(this.id, {Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context, WidgetRef ref) {
      var urlSpecies = "https://pokeapi.co/api/v2/pokemon-species/${id}/";
      var urlInfo = "https://pokeapi.co/api/v2/pokemon/${id}/";

      final pokemonSpeciesAsync = ref.watch(getPokemonSpeciesProvider(urlSpecies));
      final pokemonInfoAsync = ref.watch(getPokemonInfoProvider(urlInfo));

      return pokemonSpeciesAsync.when(
        data: (species) {
          return pokemonInfoAsync.when(
            data: (info) {
              return Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  BackgroundDecoration( pokemon:info),
                  PokemonDetailCard(pokemon: info,pokemonSpecies: species,),
                  PokemonContentInfo(pokemon: info)
                ],
              );
            },
            loading: () => Center(child: CircularProgressIndicator(),) ,
            error: (error, _) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error: $error'),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    ref.refresh(getPokemonInfoProvider(urlInfo));
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        },
        loading: () => Center(child: CircularProgressIndicator(),) ,
        error: (error, _) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error: $error'),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                ref.refresh(getPokemonSpeciesProvider(urlSpecies));
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }
}

