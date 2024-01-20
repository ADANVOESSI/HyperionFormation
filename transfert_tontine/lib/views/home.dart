import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:transfert_appli/configurations/themes.dart';
import 'package:transfert_appli/function.dart';
import 'package:transfert_appli/services/footer_page.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top,
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
            color: AppliColors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CircleAvatar(
                  backgroundImage:
                      AssetImage('assets/images/imgA.jpg'),
                  radius: 20,
                ),
                // const Spacer(),
                IconButton(
                  iconSize: 40.0,
                  icon: const Icon(
                    Icons.notifications,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                padding:
                    const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 15.0),
                color: AppliColors.mybackground,
                child: Column(
                  children: [
                    Text(
                      user?.phoneNumber ?? "",
                      style: const TextStyle(
                          fontSize: 25,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w700,
                          color: AppliColors.orange),
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
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w300,
                          color: AppliColors.white),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.all(3),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed('/maCarte');
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: AppliColors.black,
                                  backgroundColor: AppliColors.white,
                                  padding: const EdgeInsets.all(5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text("Individuelle"),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.all(3),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed('/collectif');
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: AppliColors.black,
                                  backgroundColor: AppliColors.white,
                                  padding: const EdgeInsets.all(5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text("Collective"),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.all(3),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed('/social');
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: AppliColors.black,
                                  backgroundColor: AppliColors.white,
                                  padding: const EdgeInsets.all(5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text("Sociale"),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.all(3),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed('/scolaire');
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: AppliColors.black,
                                  backgroundColor: AppliColors.white,
                                  padding: const EdgeInsets.all(5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text("Scolaire"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 200,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(8.0),
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(8.0),
                              child: Image.asset(
                                'assets/images/img4.jpeg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(8.0),
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(8.0),
                              child: Image.asset(
                                'assets/images/img2.jpeg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(8.0),
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(8.0),
                              child: Image.asset(
                                'assets/images/img3.jpeg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(8.0),
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(8.0),
                              child: Image.asset(
                                'assets/images/img1.jpeg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(8.0),
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(8.0),
                              child: Image.asset(
                                'assets/images/pexels-photo-5965913.jpeg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      "Transformez vos rêves en réalité avec notre application d'épargne, votre partenaire financier ultime. Libérez votre potentiel d'épargne avec notre application intuitive. Faites croître votre argent, faites croître vos rêves.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        color: AppliColors.white,
                      ),
                    ),
                    const SizedBox(height: 23),
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            // Votre action lorsque le container est cliqué
                          },
                          child: Container(
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius:
                                  BorderRadius.circular(8.0),
                              border: Border.all(
                                color: AppliColors.white,
                                width: 2,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment:
                                  MainAxisAlignment.center,
                              crossAxisAlignment:
                                  CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 20),
                                ColorFiltered(
                                  colorFilter: const ColorFilter.mode(
                                    AppliColors.black,
                                    BlendMode.srcIn,
                                  ),
                                  child: SvgPicture.asset(
                                    'assets/images/loan-icon.svg',
                                    width: 35,
                                    height: 35,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Payer',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    color: AppliColors.black,
                                  ),
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            // Votre action lorsque le container est cliqué
                          },
                          child: Container(
                            width: 100,
                            decoration: BoxDecoration(
                              color: AppliColors.orange,
                              borderRadius:
                                  BorderRadius.circular(8.0),
                              border: Border.all(
                                color: AppliColors.white,
                                width: 2,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment:
                                  MainAxisAlignment.center,
                              crossAxisAlignment:
                                  CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 15),
                                ColorFiltered(
                                  colorFilter: const ColorFilter.mode(
                                    AppliColors.black,
                                    BlendMode.srcIn,
                                  ),
                                  child: SvgPicture.asset(
                                    'assets/images/money-bag-icon.svg',
                                    width: 35,
                                    height: 35,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Retirer',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    color: AppliColors.black,
                                  ),
                                ),
                                const SizedBox(height: 15),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const MyFooter(),
        ],
      ),
    );
  }
}
