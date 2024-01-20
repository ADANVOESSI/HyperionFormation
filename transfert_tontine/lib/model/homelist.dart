import 'package:flutter/widgets.dart';

import '../views/paiement_views.dart';

class HomeList {
  HomeList({
    this.navigateScreen,
    this.primaryText = '',
    this.secondaryText = '',
    this.tertiaryText = '',
    this.expired,
    // this.uid,
  });

  Widget? navigateScreen;
  String primaryText;
  String secondaryText;
  String tertiaryText;
  int? expired;
  // String? uid;

  static List<HomeList> fromSnapshotData(List<Map<String, dynamic>> data) {
    return data.map((map) {
      return HomeList(
        primaryText: '${map['amount']}',
        secondaryText: '${map['nameCard'].length > 18 ? map['nameCard'].substring(0, 18) + '...' : map['nameCard']}',
        tertiaryText: '${map['expired']} mois',
        expired: map['expired'],
        // uid: map['uid'],
        navigateScreen: PaymentTypeSelectionWidget(
            // map['uid']
            ),
      );
    }).toList();
  }
}
