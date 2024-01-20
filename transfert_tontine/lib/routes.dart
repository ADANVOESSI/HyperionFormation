import 'package:flutter/material.dart';
import 'package:transfert_tontine/screens/navigation_home_screen.dart';
import 'package:transfert_tontine/screens/phone_register_screen.dart';
import 'package:transfert_tontine/views/cards/cards_details.dart';
import 'package:transfert_tontine/views/cards/create_card.dart';
import 'package:transfert_tontine/views/home.dart';
import 'package:transfert_tontine/views/proche_member_views.dart';
import 'package:transfert_tontine/views/register_views.dart';

final Map<String, WidgetBuilder> routes = {
  '/home': (BuildContext context) => const PhoneRegisterScreen(),
  '/homeScreen': (BuildContext context) => NavigationHomeScreen(),
  '/inscription': (BuildContext context) => RegisterPage(),
  '/personProche': (BuildContext context) => const PersonProchePage(),
  '/monHome': (context) => const Home(),
  // '/payment': (context) => PaymentTypeSelectionWidget(),
  '/createCards': (context) => CreateCard(),
  // '/dialogIndi': (context) => MyDialog(),
  '/parameter': (context) => CardsDetails(),
};
