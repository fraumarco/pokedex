import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/application/bloc/pokemon_detail_bloc.dart';
import 'package:pokedex/application/navigation/app_router.dart';
import 'package:pokedex/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<PokemonDetailBloc>(
      create: (context) => PokemonDetailBloc(),
      child: MaterialApp.router(
        theme: ThemeData.from(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.red)),
        routerConfig: _appRouter.config(),
      ),
    );
  }
}
