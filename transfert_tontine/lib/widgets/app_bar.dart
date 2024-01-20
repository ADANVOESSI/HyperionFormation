import 'package:flutter/material.dart';

import '../configurations/themes.dart';

class MyFlexibleSpace extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            'Bonjour',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppliColors.white,
            ),
          ),
        ),
        Text(
          'Sous-titre ou autre information',
          style: TextStyle(
            fontSize: 14,
            color: AppliColors.white,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);
}
