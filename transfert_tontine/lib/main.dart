import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:transfert_tontine/provider/auth_provider.dart';
import 'package:transfert_tontine/provider/cards_provider.dart';
import 'package:transfert_tontine/routes.dart';
import 'package:transfert_tontine/screens/phone_register_screen.dart';
import 'package:transfert_tontine/views/cards/cards_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiBlocProvider(
        providers: [
          BlocProvider<CardsBloc>(create: (context) => CardsBloc()),
          // BlocProvider<TypesPokemonsBloc>(
          //   create: (context) => TypesPokemonsBloc(),
          // ),
          // BlocProvider<ThemeCubit>(create: (context) => themeCubit),
          // BlocProvider<DataCubit>(create: (context) => dataCubit),
        ],
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => MyAuthProvider(),
            ),
            ChangeNotifierProvider(
              create: (_) => CardProvider(),
            ),
          ],
          child: const MyApp(),
        )),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: routes,
      title: 'Transfert Tontine',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: NavigationHomeScreen(),
      home: const PhoneRegisterScreen(),
    );
  }
}
