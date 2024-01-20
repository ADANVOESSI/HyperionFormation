import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:transfert_tontine/provider/cards_provider.dart';
import 'package:transfert_tontine/widgets/logo_asset_image.dart';

import '../../configurations/themes.dart';
import '../../utils/extension/option_extension.dart';
import '../../widgets/footer_widget.dart';
import '../../widgets/notifications_alert.dart';

class CreateCard extends StatefulWidget {
  const CreateCard({Key? key}) : super(key: key);

  @override
  _CreateCardState createState() => _CreateCardState();
}

class _CreateCardState extends State<CreateCard> {
  User? user = FirebaseAuth.instance.currentUser;

  OptionType? _selectedOption;
  final _formKey = GlobalKey<FormState>();
  String nameCard = '';
  int expired = 1;
  int enteredAmount = 200;

  @override
  void initState() {
    super.initState();
    _selectedOption = OptionType.bloque;
  }

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
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            color: AppliColors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const LogoImage(),
                Text(
                  user?.phoneNumber ?? "",
                  style: const TextStyle(fontSize: 20, fontFamily: 'Poppins', fontWeight: FontWeight.w700, color: AppliColors.orange),
                ),
                // const Spacer(),
                const NotificationAlert(),
              ],
            ),
          ),
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 20),
              color: AppliColors.mybackground,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      width: double.infinity,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Création de carte tontine',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            color: AppliColors.mybackground,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Entrer le montant à épargner chaque jour et le nombre de mois pour créer une carte de tontine avec votre numéro MTN Mobile Money, Moov Money et Celtiis Cash',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        color: AppliColors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      child: PhysicalShape(
                        clipper: ShapeBorderClipper(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        elevation: 16,
                        color: AppliColors.white,
                        child: Form(
                          key: _formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 20),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 5),
                                            const Text(
                                              'Nom de la tontine :',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color: AppliColors.black,
                                                fontSize: 13,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(height: 6),
                                            Container(
                                              decoration: const BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black12,
                                                    blurRadius: 6,
                                                    offset: Offset(0, 5),
                                                  ),
                                                ],
                                              ),
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: AppliColors.white,
                                                  hintText: 'Mon Iphone 12',
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(6),
                                                    borderSide: const BorderSide(color: AppliColors.blue),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(6),
                                                    borderSide: const BorderSide(color: AppliColors.blue),
                                                  ),
                                                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                                                ),
                                                validator: (value) {
                                                  if (value == null || value.trim().isEmpty) {
                                                    return 'Veuillez renseigner votre nom';
                                                  }
                                                  return null;
                                                },
                                                onChanged: (value) => nameCard = value,
                                                onSaved: (value) => nameCard = value!.trim(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 20),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Montant :',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color: AppliColors.black,
                                                fontSize: 13,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(height: 6),
                                            Container(
                                              decoration: const BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black12,
                                                    blurRadius: 6,
                                                    offset: Offset(0, 5),
                                                  ),
                                                ],
                                              ),
                                              child: TextFormField(
                                                keyboardType: TextInputType.number,
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: AppliColors.white,
                                                  hintText: '1000 F',
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(6),
                                                    borderSide: const BorderSide(color: AppliColors.blue),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(6),
                                                    borderSide: const BorderSide(color: AppliColors.blue),
                                                  ),
                                                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                                                  prefix: const Text('CFA ', style: TextStyle(color: AppliColors.black, fontWeight: FontWeight.w400, fontFamily: 'Poppins', fontSize: 16.0)),
                                                  prefixIconConstraints: const BoxConstraints(),
                                                ),
                                                onChanged: (value) {
                                                  if (value.isNotEmpty) {
                                                    enteredAmount = int.parse(value);
                                                  } else {
                                                    enteredAmount = 0;
                                                  }
                                                },
                                                validator: (value) {
                                                  if (enteredAmount < 200) {
                                                    return 'Le montant doit être supérieur ou égal à 200';
                                                  }
                                                  return null;
                                                },
                                                onSaved: (value) => enteredAmount,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 20),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Durée :',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color: AppliColors.black,
                                                fontSize: 13,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(height: 6),
                                            Container(
                                              decoration: const BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black12,
                                                    blurRadius: 6,
                                                    offset: Offset(0, 5),
                                                  ),
                                                ],
                                              ),
                                              child: TextFormField(
                                                keyboardType: TextInputType.number,
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: AppliColors.white,
                                                  hintText: '1',
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(6),
                                                    borderSide: const BorderSide(color: AppliColors.blue),
                                                  ),
                                                  suffix: const Text(' mois', style: TextStyle(color: AppliColors.black, fontWeight: FontWeight.w400, fontFamily: 'Poppins', fontSize: 16.0)),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(6),
                                                    borderSide: const BorderSide(color: AppliColors.blue),
                                                  ),
                                                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                                                ),
                                                validator: (value) {
                                                  if (value == null || value.trim().isEmpty) {
                                                    return "Veuillez renseigner l'échéance";
                                                  }
                                                  return null;
                                                },
                                                onChanged: (value) {
                                                  if (value.isNotEmpty) {
                                                    expired = int.parse(value);
                                                  } else {
                                                    expired = 0;
                                                  }
                                                  // validateInputs();
                                                },
                                                onSaved: (value) => expired,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                RadioListTile<OptionType>(
                                  value: OptionType.bloque,
                                  groupValue: _selectedOption,
                                  onChanged: (OptionType? value) {
                                    // context.read<CardsBloc>().add(SelectedOptionEvent(OptionType.bloque));
                                    setState(() {
                                      _selectedOption = value;
                                    });
                                  },
                                  activeColor: AppliColors.mybackground,
                                  controlAffinity: ListTileControlAffinity.leading,
                                  title: const Text(
                                    'Option bloquée (Vous devriez finir la carte avant tout retrait)',
                                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400, color: Colors.black),
                                  ),
                                ),
                                RadioListTile<OptionType>(
                                  title: const Text(
                                    'Option libre (Vous autorise à arrêter votre carte à tout moment)',
                                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400, color: Colors.black),
                                  ),
                                  value: OptionType.libre,
                                  groupValue: _selectedOption,
                                  onChanged: (OptionType? value) {
                                    // context.read<CardsBloc>().add(SelectedOptionEvent(OptionType.libre));
                                    setState(() {
                                      _selectedOption = value;
                                    });
                                  },
                                  activeColor: AppliColors.mybackground,
                                  controlAffinity: ListTileControlAffinity.leading,
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  width: 150,
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 38,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        _showAddConfirmationDialog(context);
                                      },
                                      // _submitForm,
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: AppliColors.white,
                                        backgroundColor: AppliColors.mybackground,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: const Text(
                                        'Créer',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                      ),
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

  void _showAddConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                color: AppliColors.black,
              ),
              children: <TextSpan>[
                TextSpan(text: "Vous êtes sur le point de créer une carte de "),
                TextSpan(
                  text: "$enteredAmount F",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: AppliColors.black,
                  ),
                ),
                TextSpan(text: ", pour nom ' "),
                TextSpan(
                  text: "${nameCard.toString()}",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: AppliColors.black,
                  ),
                ),
                TextSpan(text: " ' d'une durée de "),
                TextSpan(
                  text: "$expired mois",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: AppliColors.black,
                  ),
                ),
                TextSpan(text: " en option "),
                TextSpan(
                  text: "${_selectedOption?.value ?? ''}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.underline,
                    color: AppliColors.red,
                  ),
                ),
                TextSpan(text: ". C'est bien cela ?"),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppliColors.red,
                    foregroundColor: AppliColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text(
                    'Annuler',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppliColors.green,
                    foregroundColor: AppliColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: () async {
                    CardProvider cardProvider = CardProvider();
                    try {
                      String cardId = await cardProvider.registerCard(
                        userId: user!.uid,
                        nameCard: nameCard.toString(),
                        enteredAmount: enteredAmount,
                        expired: expired,
                        option: _selectedOption?.value ?? '',
                        status: 'en cours',
                        createdAt: DateTime.now(),
                      );
                      Navigator.of(context).pop(true);
                      Navigator.of(context).pushReplacementNamed('/payment', arguments: cardId);
                    } catch (e) {}
                  },
                  child: const Text(
                    'Valider',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
