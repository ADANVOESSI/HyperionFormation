import 'package:flutter/material.dart';

import '../configurations/themes.dart';

class MyFooter extends StatelessWidget {
  const MyFooter({super.key});

  @override
  Widget build(BuildContext context) {
    const iconColor = AppliColors.mybackground;
    const textColor = AppliColors.mybackground;

    return Container(
      width: double.infinity,
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: Column(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.home,
                    color: iconColor,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/homeScreen');
                  },
                ),
                const Text(
                  'Home',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
          // Expanded(
          //   child: Column(
          //     children: [
          //       IconButton(
          //         icon: const Icon(
          //           Icons.groups,
          //           color: iconColor,
          //         ),
          //         onPressed: () {},
          //       ),
          //       const Text(
          //         'Groupe',
          //         style: TextStyle(
          //           fontFamily: 'Poppins',
          //           fontWeight: FontWeight.w500,
          //           color: textColor,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppliColors.mybackground,
            ),
            child: IconButton(
              iconSize: 35.0,
              icon: const Icon(
                Icons.add,
                color: AppliColors.white,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed('/createCards');
              },
            ),
          ),
          // Expanded(
          //   child: Column(
          //     children: [
          //       IconButton(
          //         icon: const Icon(
          //           Icons.account_balance_wallet,
          //           color: iconColor,
          //         ),
          //         onPressed: () {},
          //       ),
          //       const Text(
          //         'Caisse',
          //         style: TextStyle(
          //           fontFamily: 'Poppins',
          //           fontWeight: FontWeight.w500,
          //           color: textColor,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          Expanded(
            child: Column(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.settings,
                    color: iconColor,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/parameter');
                  },
                ),
                const Text(
                  'Paramètre',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
