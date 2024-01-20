import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// import 'package:transfert_appli/configurations/themes.dart';
// import 'package:transfert_appli/function.dart';
// import 'package:transfert_appli/services/footer_page.dart';

import '../configurations/themes.dart';
import '../provider/cards_provider.dart';
import '../widgets/logo_asset_image.dart';
import '../widgets/notifications_alert.dart';
import 'cards/calendar_payment.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<Map<String, dynamic>>>? userCards;
  CardProvider cardProvider = CardProvider();

  @override
  void initState() {
    super.initState();
    userCards = cardProvider.fetchUserCards();
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top,
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
            color: AppliColors.white,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LogoImage(),
                NotificationAlert(),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 15.0),
                color: AppliColors.mybackground,
                child: Column(
                  children: [
                    Text(
                      user?.phoneNumber ?? "",
                      style: const TextStyle(fontSize: 25, fontFamily: "Poppins", fontWeight: FontWeight.w700, color: AppliColors.orange),
                    ),
                    const SizedBox(height: 1),
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: AppliColors.orange,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Choisissez un type épargne pour accéder à votre espace tontine",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, fontFamily: "Poppins", fontWeight: FontWeight.w300, color: AppliColors.white),
                    ),
                    const SizedBox(height: 20),
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
                            return Container(
                              alignment: Alignment.topCenter,
                              child: PhysicalShape(
                                clipper: ShapeBorderClipper(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                ),
                                elevation: 16,
                                color: AppliColors.white,
                                child: Container(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                    "Vous n'avez aucune carte en cours... Veuillez cliquer sur  \" + \"  pour créer vos cartes de tontine",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return ListView.builder(
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
                            );
                          }
                        },
                      ),
                    ),
                    // const SizedBox(height: 18),
                    // const Text(
                    //   "Transformez vos rêves en réalité avec notre application d'épargne, votre partenaire financier ultime. Libérez votre potentiel d'épargne avec notre application intuitive. Faites croître votre argent, faites croître vos rêves.",
                    //   textAlign: TextAlign.center,
                    //   style: TextStyle(
                    //     fontSize: 16,
                    //     fontFamily: 'Poppins',
                    //     fontWeight: FontWeight.w400,
                    //     color: AppliColors.white,
                    //   ),
                    // ),
                    // const SizedBox(height: 23),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     InkWell(
                    //       onTap: () {},
                    //       child: Container(
                    //         width: 100,
                    //         decoration: BoxDecoration(
                    //           color: Colors.green,
                    //           borderRadius: BorderRadius.circular(8.0),
                    //           border: Border.all(
                    //             color: AppliColors.white,
                    //             width: 2,
                    //           ),
                    //         ),
                    //         child: Column(
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           crossAxisAlignment: CrossAxisAlignment.center,
                    //           children: [
                    //             const SizedBox(height: 20),
                    //             ColorFiltered(
                    //               colorFilter: const ColorFilter.mode(
                    //                 AppliColors.black,
                    //                 BlendMode.srcIn,
                    //               ),
                    //               child: SvgPicture.asset(
                    //                 'assets/images/loan-icon.svg',
                    //                 width: 35,
                    //                 height: 35,
                    //               ),
                    //             ),
                    //             const SizedBox(height: 8),
                    //             const Text(
                    //               'Payer',
                    //               style: TextStyle(
                    //                 fontFamily: 'Poppins',
                    //                 fontWeight: FontWeight.w600,
                    //                 color: AppliColors.black,
                    //               ),
                    //             ),
                    //             const SizedBox(height: 10),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //     InkWell(
                    //       onTap: () {},
                    //       child: Container(
                    //         width: 100,
                    //         decoration: BoxDecoration(
                    //           color: AppliColors.orange,
                    //           borderRadius: BorderRadius.circular(8.0),
                    //           border: Border.all(
                    //             color: AppliColors.white,
                    //             width: 2,
                    //           ),
                    //         ),
                    //         child: Column(
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           crossAxisAlignment: CrossAxisAlignment.center,
                    //           children: [
                    //             const SizedBox(height: 15),
                    //             ColorFiltered(
                    //               colorFilter: const ColorFilter.mode(
                    //                 AppliColors.black,
                    //                 BlendMode.srcIn,
                    //               ),
                    //               child: SvgPicture.asset(
                    //                 'assets/images/money-bag-icon.svg',
                    //                 width: 35,
                    //                 height: 35,
                    //               ),
                    //             ),
                    //             const SizedBox(height: 8),
                    //             const Text(
                    //               'Retirer',
                    //               style: TextStyle(
                    //                 fontFamily: 'Poppins',
                    //                 fontWeight: FontWeight.w600,
                    //                 color: AppliColors.black,
                    //               ),
                    //             ),
                    //             const SizedBox(height: 15),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
          ),
          // const MyFooter(),
        ],
      ),
      floatingActionButton: InkWell(
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: AppliColors.white,
            borderRadius: BorderRadius.circular(50.0),
          ),
          child: Icon(
            Icons.add,
          ),
        ),
        onTap: () {
          Navigator.of(context).pushNamed('/createCards');
        },
      ),
    );
  }
}
