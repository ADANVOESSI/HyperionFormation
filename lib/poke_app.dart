import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pokemon/poke_routes.dart';
import 'package:pokemon/poke_theme.dart';

class PokeApp extends StatelessWidget {
  const PokeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('fr'),
      ],
      theme: PokeTheme.themeLight,
      routerConfig: pokeRoutes,
      // routerDelegate: pokeRoutes.routerDelegate,
      // routeInformationParser: pokeRoutes.routeInformationParser,
      // home: _Home(),
    );
  }
}

// class _Home extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return const SafeArea(child: Scaffold(body: MyHomePage()));
//   }
// }
