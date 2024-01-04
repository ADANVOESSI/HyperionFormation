import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // Centre les éléments verticalement
          children: [
            const Text('Bienvenue sur Movie App!'),
            const SizedBox(height: 20),
            // Espacement entre le texte et les boutons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // Espacement égal entre les boutons
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/addEditMoviePage');
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color(0xFF005992),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Ajouter un film",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/listfilms');
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color(0xFF005992),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Voir liste",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
