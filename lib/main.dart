import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:pokedexsprout/presentation/pages/home.dart';
import 'package:pokedexsprout/presentation/pages/pokemon_detail/pokemon_detail.dart';
import 'package:pokedexsprout/presentation/provider/pokemon_provider.dart';
import 'package:pokedexsprout/presentation/themes/colors.dart';
import 'package:pokedexsprout/presentation/themes/themes.dart';
import 'package:pokedexsprout/presentation/themes/themes/themes.light.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AppTheme  appTheme  =  LightAppTheme();

    return MaterialApp(
      title: 'Pokedex Sprout',
      theme: appTheme.themeData,
      routes : {
        '/': (context) => SplashScreenPage(title: 'SplashScreenPage'),
        '/home': (context) => HomePage(),
        '/detail/page': (context) => PokemonDetailPage()
      }
    );
  }
}

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<SplashScreenPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SplashScreenPage> {

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 5),(){
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => HomePage(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Column(
              // Column is also a layout widget. It takes a list of children and
              // arranges them vertically. By default, it sizes itself to fit its
              // children horizontally, and tries to be as tall as its parent.
              //
              // Column has various properties to control how it sizes itself and
              // how it positions its children. Here we use mainAxisAlignment to
              // center the children vertically; the main axis here is the vertical
              // axis because Columns are vertical (the cross axis would be
              // horizontal).
              //
              // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
              // action in the IDE, or press "p" in the console), to see the
              // wireframe for each widget.
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Lottie.asset(
                  'assets/animations/poke_ball.json', // Path to your Lottie file
                  width: 200,
                  height: 200,
                  repeat: true, // Loops the animation
                  reverse: true, // Play in reverse
                  animate: true, // Auto start animation
                ),
              ],
            ),
          ),
        )
    );
  }

}

