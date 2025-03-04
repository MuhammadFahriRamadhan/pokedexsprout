import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:pokedexsprout/presentation/widgets/positioned_poke_ball.dart';

import '../provider/pokemon_provider.dart';
import '../widgets/pokemon_grid.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Align(
              alignment: Alignment.centerLeft, // Center the text like an AppBar title
              child: Padding(
                padding: EdgeInsets.only(top: 50,left: 10),
                child: Text(
                  'Pokedex',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
              )
            ),
            PositionedPokeball(),
          ],
        ),
      ),
      body: Stack(
        children: [
          Stack(
            children: [PokemonGridConsumer()],
          )
        ],
      ) ,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        },
        backgroundColor: Colors.white, // Adjust based on your animation
        child: Lottie.asset(
          'assets/animations/poke_ball.json',
          width: 60,
          height: 60,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class PokemonGridConsumer extends ConsumerWidget {
  const PokemonGridConsumer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonAsync = ref.watch(getPokemonProvider);

    return RefreshIndicator(
      onRefresh: () async {
        ref.refresh(getPokemonProvider);
      },
      child: pokemonAsync.when(
        data: (pokemons) => CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.all(8),
              sliver: PokemonGrid(pokemons: pokemons), // Ensure PokemonGrid returns a SliverGrid
            ),
          ],
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, _) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error: $error'),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                ref.refresh(getPokemonProvider);
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

