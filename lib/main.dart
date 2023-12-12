import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pokemon/firebase_options.dart';
import 'package:pokemon/poke_theme.dart';
import 'package:pokemon/rooter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pokemon/widgets/add_pokemons.dart';
import 'package:pokemon/widgets/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      darkTheme: PokeTheme.themeDark,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: routes,
      onGenerateRoute: (settings) {
        WidgetBuilder builder = (_) {
          return const Scaffold(body: Center(child: Text('Route inconnue')));
        };

        switch (settings.name) {
          case '/home':
            builder = (BuildContext _) => Theme(
                  data: PokeTheme.themeDark,
                  child: const MyHomePage(),
                );
            break;
          case '/addPokemons':
            builder = (BuildContext _) => Theme(
                  data: PokeTheme.themeDark,
                  child: const AddPokemons(),
                );
            break;
        }

        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}
