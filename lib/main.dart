import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/blocs/pokemons/pokemons_bloc.dart';
import 'package:pokemon/blocs/pokemons/pokemons_events.dart';
import 'package:pokemon/firebase_options.dart';
import 'package:pokemon/poke_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // runApp(const PokeApp());
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<PokemonsBloc>(
          create: (context) => PokemonsBloc()..add(LoadPokemons()),
        ),
        // ... Autres BlocProviders nécessaires dans votre application
      ],
      child: const PokeApp(),
    ),
  );
}
