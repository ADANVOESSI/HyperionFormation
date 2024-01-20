// import 'package:cassandre/blocs/authentification/authentication.dart';
// import 'package:cassandre/model/arguments/intervention_arguments.dart';
// import 'package:cassandre/model/arguments/interventions_arguments.dart';
// import 'package:cassandre/model/arguments/mase_arguments.dart';
// import 'package:cassandre/screen/account_screen.dart';
// import 'package:cassandre/screen/intervention_screen.dart';
// import 'package:cassandre/screen/mase_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
// import 'package:get_it/get_it.dart';
// import 'package:go_router/go_router.dart';
//
// import '../model/arguments/arguments_three_dimensional.dart';
// import '../model/arguments/intervention_prestations_arguments.dart';
//
// import 'package:cassandre/screen/3d_reader_screen.dart'
// if (dart.library.html) 'package:cassandre/screen/web_3d_reader_screen.dart' as my_worker;

// import '../screen/authentication_screen.dart';
// import '../screen/home_screen.dart';
// import '../screen/prestations_screen.dart';
// import '../widget/intervention_cards.dart';

// GoRouter routerGenerator() {
//   return GoRouter(
//     initialLocation: RoutesConfig.home,
//     refreshListenable: GetIt.instance.get<AuthenticationBloc>(),
//     redirect: (context, state) {
//       final isOnLogin = state.matchedLocation == RoutesConfig.login;
//       final isLoggedIn = GetIt.instance.get<AuthenticationBloc>().state is AuthenticatedState;
//
//       if (!isOnLogin && !isLoggedIn) return RoutesConfig.login;
//       if (isOnLogin && isLoggedIn) return RoutesConfig.home;
//       return null;
//     },
//     // routes: <RouteBase>[
//       // GoRoute(
//       //   path: RoutesConfig.home, // '/'
//       //   builder: (BuildContext context, GoRouterState state) {
//       //     return const HomeScreen();
//       //   },
//       // ),
//       // GoRoute(
//       //   path: RoutesConfig.login, // 'login'
//       //   builder: (BuildContext context, GoRouterState state) {
//       //     return const AuthentificationScreen();
//       //   },
//       // ),
//       // GoRoute(
//       //   path: RoutesConfig.interventions, // 'interventions'
//       //   builder: (BuildContext context, GoRouterState state) {
//       //     if (state.extra != null && state.extra is InterventionsArguments) {
//       //       return InterventionCards(filter: (state.extra as InterventionsArguments).filters, title: (state.extra as InterventionsArguments).title, withScaffold: true);
//       //     }
//       //     return const InterventionCards();
//       //   },
//       // ),
//       // GoRoute(
//       //   path: RoutesConfig.account,
//       //   builder: (BuildContext context, GoRouterState state) {
//       //     return const AccountScreen();
//       //   },
//       // ),
//       // GoRoute(
//       //   path: RoutesConfig.intervention, // 'intervention'
//       //   builder: (BuildContext context, GoRouterState state) {
//       //     if (state.extra != null && state.extra is InterventionArguments) {
//       //       return InterventionScreen(args: state.extra as InterventionArguments);
//       //     }
//       //     return const InterventionScreen();
//       //   },
//       //   routes: <RouteBase>[
//       //     GoRoute(
//       //       name: 'prestations',
//       //       path: 'prestations', // 'prestations'
//       //       builder: (BuildContext context, GoRouterState state) {
//       //         if (state.extra != null && state.extra is InterventionPrestationsArguments) {
//       //           return PrestationsScreen(args: state.extra as InterventionPrestationsArguments);
//       //         }
//       //         return const PrestationsScreen();
//       //       },
//       //     ),
//           // GoRoute(
//           //   name: 'departure-mase',
//           //   path: 'departure-mase',
//           //   builder: (BuildContext context, GoRouterState state) {
//           //     if (state.extra != null && state.extra is MaseArguments) {
//           //       return MaseScreen(args: state.extra as MaseArguments);
//           //     }
//           //     return Container();
//           //   },
//           // ),
//           // GoRoute(
//           //   name: 'arrival-mase',
//           //   path: 'arrival-mase',
//           //   builder: (BuildContext context, GoRouterState state) {
//           //     if (state.extra != null && state.extra is MaseArguments) {
//           //       return MaseScreen(args: state.extra as MaseArguments);
//           //     }
//           //     return Container();
//           //   },
//           // ),
//         // ],
//       // ),
//       // GoRoute(
//       //   path: '/ThreeDimensionalReader',
//       //   builder: (BuildContext context, GoRouterState state) {
//       //     if (state.extra != null && state.extra is ArgumentsThreeDimensional) {
//       //       if (kIsWeb) {
//       //         return my_worker.ThreeDimensionalReader(coord: state.extra as ArgumentsThreeDimensional);
//       //       } else {
//       //         return my_worker.ThreeDimensionalReader(coord: state.extra as ArgumentsThreeDimensional);
//       //       }
//       //     }
//       //     return Container();
//       //   },
//       // ),
//     ],
//   );
// }

class RoutesConfig {
  static const home = '/';
  static const login = '/login';
  static const interventions = '/interventions';
  static const intervention = '/intervention/:id';
  static const prestations = 'prestations';
  static const diagnostic = '/intervention/diagnostic';
  static const singleElement = '/intervention/diagnostic/element';
  static const arrivalMase = 'arrival-mase';
  static const departureMase = 'departure-mase';
  static const calendar = '/calendrier';
  static const account = '/account';
}
