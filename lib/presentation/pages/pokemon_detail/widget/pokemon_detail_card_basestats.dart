part of '../pokemon_detail.dart';

class StatPokeDex extends StatelessWidget {
  final Animation animation;
  final String label;
  final double? progress;
  final num value;

  const StatPokeDex({
    super.key,
    required this.animation,
    required this.label,
    required this.value,
    this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children:  <Widget>[
          Expanded(
           flex: 2,
           child: Text(
            label,
            style: TextStyle(color: Theme.of(context).textTheme.bodySmall!.color!.withOpacity(0.6)),)
          ),
          Expanded(
              flex: 1,
              child: Text('$value')
          ),
          Expanded(
              flex: 5,
              child: AnimatedBuilder(
                  animation: animation, 
                  builder: (context, widget) {
                    final currentProgress = progress ?? value / 100;
                    
                    return ProgressBar(
                      progress: animation.value * currentProgress,
                      color: currentProgress < 0.5 ? AppColors.red : AppColors.teal,
                      enableAnimation: animation.value == 1,
                    );
                  }))
      ],
    );
  }
}

class PokemonBaseStats extends StatefulWidget {
  final PokemonInfoResponse pokemon;

  const PokemonBaseStats(this.pokemon);

  @override
  State<PokemonBaseStats> createState() => _PokemonBaseStatsState();
}

class _PokemonBaseStatsState extends State<PokemonBaseStats> with SingleTickerProviderStateMixin{
  late Animation<double> progressAnimation;
  late AnimationController progressController;
  late PokemonInfoResponse pokemon;
  AnimationController get slideController => PokemonDetailStateProvider.of(context).sliderAnimationController;


  @override
  void initState() {
    pokemon = widget.pokemon;
    progressController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 400)
    );

    progressAnimation = Tween<double>(begin: 0.0,end: 1.0).animate(CurvedAnimation(parent: progressController, curve: Curves.easeInOut));

    progressController.forward();

    super.initState();
  }

  @override
  void dispose() {
    progressController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: slideController,
        builder: (contex,child){
          final scrollable = slideController.value.floor() == 1;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            physics: scrollable ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
            child: child,
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            buildStatsDex(pokemon),
            const SizedBox(height: 27,),
            const Text('Type defense',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                height: 0.8
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'The effectiveness of each type on ${pokemon.name}.',
              style: TextStyle(color: AppColors.black.withOpacity(0.6)),
            ),
            const SizedBox(height: 15),
            buildEffectivenesses(pokemon.typeEffectiveness),
          ],
        ),
        );
  }

  Widget buildStatsDex(PokemonInfoResponse pokemon){
     final totalStat = pokemon.stats.map((e) => e.baseStat).fold(0, (a, b) => a + b);
     return Column(
       mainAxisSize: MainAxisSize.min,
       crossAxisAlignment: CrossAxisAlignment.stretch,
       children: [
         StatPokeDex(animation: progressAnimation, label: 'Hp', value: pokemon.stats.where( (e) => e.stat.name.toLowerCase() == 'hp' ).first.baseStat),
         const SizedBox(height: 14,),
         StatPokeDex(animation: progressAnimation, label: 'Attack', value: pokemon.stats.where( (e) => e.stat.name.toLowerCase() == 'attack').first.baseStat),
         const SizedBox(height: 14,),
         StatPokeDex(animation: progressAnimation, label: 'Defense', value: pokemon.stats.where( (e) => e.stat.name.toLowerCase() == 'defense').first.baseStat),
         const SizedBox(height: 14,),
         StatPokeDex(animation: progressAnimation, label: 'Sp. Atk', value: pokemon.stats.where( (e) => e.stat.name.toLowerCase() == 'special-attack').first.baseStat),
         const SizedBox(height: 14,),
         StatPokeDex(animation: progressAnimation, label: 'Sp. Def', value: pokemon.stats.where( (e) => e.stat.name.toLowerCase() == 'special-defense').first.baseStat),
         const SizedBox(height: 14,),
         StatPokeDex(animation: progressAnimation, label: 'Speed', value: pokemon.stats.where( (e) => e.stat.name.toLowerCase() == 'speed').first.baseStat),
         const SizedBox(height: 14),
         StatPokeDex(
           animation: progressAnimation,
           label: 'Total',
           value: totalStat,
           progress: totalStat / 600,
         ),
       ],
     );
  }

  Widget buildEffectivenesses(Map<ColorPokemon, double> typeEffectiveness) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: typeEffectiveness.keys
          .map(
            (type) => PokemonType(
          TypeEntity(slot: 0,type: SpeciesEntity(name: type.name, url: "url"),color: type.color),
          large: true,
          colored: true,
          extra: 'x${removeTrailingZero(typeEffectiveness[type] ?? 1)}',
        ),
      )
          .toList(),
    );
  }


}

