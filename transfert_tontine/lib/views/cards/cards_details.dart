import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:transfert_tontine/provider/cards_provider.dart';

import '../../configurations/themes.dart';
import 'calendar_payment.dart';

class CardsDetails extends StatefulWidget {
  const CardsDetails({super.key});

  @override
  State<CardsDetails> createState() => _CardsDetailsState();
}

class _CardsDetailsState extends State<CardsDetails> {
  User? user = FirebaseAuth.instance.currentUser;
  Future<List<Map<String, dynamic>>>? userCards;
  CardProvider cardProvider = CardProvider();

  @override
  void initState() {
    super.initState();
    userCards = cardProvider.fetchUserCards();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: AppliColors.transparent,
      //   elevation: 0,
      //   title: Text('Bonjour'),
      //   leading: IconButton(
      //     iconSize: 28,
      //     icon: const Icon(Icons.arrow_back),
      //     onPressed: () => Navigator.of(context).pop(),
      //   ),
      // ),
      body: Container(
        color: AppliColors.mybackground,
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).padding.top,
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 20.0),
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: AppliColors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: IconButton(
                        iconSize: 35.0,
                        icon: const Icon(
                          Icons.arrow_back,
                          color: AppliColors.mybackground,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Ici, retrouvez la liste de toutes les cartes de tontines auxquelles vous avez souscrit.',
                      style: TextStyle(fontSize: 16, color: AppliColors.white, fontFamily: 'Poppins', fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: userCards,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Erreur: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('Aucune carte d\'utilisateur trouvée.');
                  } else {
                    return DefaultTabController(
                      length: 2,
                      child: Scaffold(
                        body: Column(
                          children: [
                            const TabBar(
                              tabs: [
                                Tab(
                                  child: SizedBox(
                                    width: 40,
                                    height: 30,
                                    child: Icon(Icons.list, size: 35),
                                  ),
                                ),
                                Tab(
                                  child: SizedBox(
                                    width: 40,
                                    height: 25,
                                    child: Icon(Icons.dashboard, size: 35),
                                  ),
                                ),
                              ],
                              labelColor: AppliColors.mybackground,
                            ),
                            Expanded(
                              child: TabBarView(
                                children: [
                                  Container(
                                    color: AppliColors.mybackground,
                                    child: ListView.builder(
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        return Card(
                                          child: ListTile(
                                            leading: Container(
                                              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                                              decoration: BoxDecoration(
                                                color: AppliColors.mybackground,
                                                borderRadius: BorderRadius.circular(10.0),
                                              ),
                                              child: Text(
                                                '${snapshot.data![index]['amount']}',
                                                style: TextStyle(
                                                  color: AppliColors.white,
                                                  fontSize: 20,
                                                  fontFamily: 'Poppins',
                                                ),
                                              ),
                                            ),
                                            title: Text(
                                              '${snapshot.data![index]['nameCard'].length > 20 ? snapshot.data![index]['nameCard'].substring(0, 20) + '...' : snapshot.data![index]['nameCard']}',
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: AppliColors.mybackground,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            subtitle: Text(
                                              '${snapshot.data![index]['expired']} mois',
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: AppliColors.mybackground,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            trailing: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: AppliColors.green,
                                                foregroundColor: AppliColors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => DynamicCalendar(
                                                      echeance: snapshot.data![index]['expired'],
                                                      joursPayes: 41,
                                                      // cardId: snapshot.data![index]['uid'],
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: const Text(
                                                'Voir',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontFamily: 'Poppins',
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Container(
                                    color: AppliColors.mybackground,
                                    child: GridView.builder(
                                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                      ),
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => DynamicCalendar(
                                                  echeance: snapshot.data![index]['expired'],
                                                  joursPayes: 30,
                                                  // cardId: snapshot.data![index]['uid'],
                                                ),
                                              ),
                                            );
                                          },
                                          child: Card(
                                            color: AppliColors.white,
                                            child: GridTile(
                                              child: Center(
                                                child: SizedBox(
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        alignment: Alignment.center,
                                                        padding: EdgeInsets.symmetric(vertical: 8),
                                                        child: Text(
                                                          '${snapshot.data![index]['nameCard'].length > 10 ? snapshot.data![index]['nameCard'].substring(0, 10) + '...' : snapshot.data![index]['nameCard']}',
                                                          style: TextStyle(
                                                            color: AppliColors.mybackground,
                                                            fontSize: 16,
                                                            fontFamily: 'Poppins',
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        alignment: Alignment.center,
                                                        padding: EdgeInsets.symmetric(vertical: 8),
                                                        width: double.infinity,
                                                        color: AppliColors.mybackground,
                                                        child: Text(
                                                          '${snapshot.data![index]['amount']} Fcfa',
                                                          style: TextStyle(
                                                            color: AppliColors.white,
                                                            fontSize: 16,
                                                            fontFamily: 'Poppins',
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        alignment: Alignment.center,
                                                        padding: EdgeInsets.symmetric(vertical: 8),
                                                        width: double.infinity,
                                                        child: Text(
                                                          '${snapshot.data![index]['expired']} mois',
                                                          style: TextStyle(
                                                            color: AppliColors.mybackground,
                                                            fontSize: 16,
                                                            fontFamily: 'Poppins',
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
