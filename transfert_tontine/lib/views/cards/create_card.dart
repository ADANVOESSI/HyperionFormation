import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transfert_tontine/widgets/logo_asset_image.dart';

import '../configurations/themes.dart';
import '../provider/cards_provider.dart';
import '../widgets/footer_widget.dart';
import '../widgets/notifications_alert.dart';

enum OptionType { libre, bloque }

extension OptionTypeExtension on OptionType {
  String get value {
    switch (this) {
      case OptionType.libre:
        return 'libre';
      case OptionType.bloque:
        return 'bloque';
      default:
        return 'bloque';
    }
  }
}

class CreateCard extends StatefulWidget {
  const CreateCard({Key? key}) : super(key: key);

  @override
  _CreateCardState createState() => _CreateCardState();
}

class _CreateCardState extends State<CreateCard> {
  User? user = FirebaseAuth.instance.currentUser;

  OptionType? _selectedOption;
  final TextEditingController _controller = TextEditingController(text: 'Number');
  final _formKey = GlobalKey<FormState>();
  String nameCard = '';
  String userId = '';
  String paymentNumber = '';
  int expired = 1;
  int enteredAmount = 200;

  @override
  void initState() {
    super.initState();
    _controller.text = user!.phoneNumber.toString();
    _selectedOption = OptionType.bloque;
  }

  void _resetForm() {
    _formKey.currentState!.reset();
  }

  void _submitForm() async {
    final authProvider = Provider.of<CardProvider>(context, listen: false);

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        await authProvider.registerCard(
          userId: user!.uid,
          nameCard: nameCard,
          enteredAmount: enteredAmount,
          expired: expired,
          paymentNumber: paymentNumber,
          option: _selectedOption?.value ?? '',
        );

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Contact ajouté avec succès! Vous serez redirigé pour créer votre compte dans quelques secondes!'),
          duration: Duration(seconds: 6),
        ));

        Navigator.of(context).pushNamed('/personProche');

        _resetForm();
      } catch (error) {
        print(error.toString());

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.error, color: Colors.red),
                SizedBox(width: 10),
                Expanded(child: Text('Une erreur est survenue lors de l\'ajout du contact.')),
              ],
            ),
            backgroundColor: Colors.grey[800],
            duration: const Duration(seconds: 5),
            action: SnackBarAction(
              label: 'Réessayer',
              onPressed: () {},
            ),
          ),
        );
      }
    }
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
            padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
            color: AppliColors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const LogoImage(),
                Text(
                  user?.phoneNumber ?? "",
                  style: const TextStyle(fontSize: 20, fontFamily: "Poppins", fontWeight: FontWeight.w700, color: AppliColors.orange),
                ),
                // const Spacer(),
                const NotificationAlert(),
              ],
            ),
          ),
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 20.0),
              color: AppliColors.mybackground,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(10.0),
                    width: double.infinity,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Création de carte tontine',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold,
                          color: AppliColors.mybackground,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Entrer le montant à épargner chaque jour et le nombre de mois pour créer une carte de tontine avec votre numéro MTN Mobile Money, Moov Money et Celtiis Cash",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      color: AppliColors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                      child: PhysicalShape(
                        clipper: ShapeBorderClipper(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        elevation: 16,
                        color: AppliColors.background,
                        child: Form(
                          key: _formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 20.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Nom de la tontine :",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color: AppliColors.black,
                                                fontSize: 13,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            Container(
                                              decoration: const BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black12,
                                                    blurRadius: 6.0,
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
                                                    borderRadius: BorderRadius.circular(6.0),
                                                    borderSide: const BorderSide(color: AppliColors.blue),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(6.0),
                                                    borderSide: const BorderSide(color: AppliColors.blue),
                                                  ),
                                                  contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                                                ),
                                                validator: (value) {
                                                  if (value == null || value.trim().isEmpty) {
                                                    return "Veuillez renseigner votre nom";
                                                  }
                                                  return null;
                                                },
                                                onSaved: (value) => nameCard = value!.trim(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 20.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Montant :",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color: AppliColors.black,
                                                fontSize: 13,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            Container(
                                              decoration: const BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black12,
                                                    blurRadius: 6.0,
                                                    offset: Offset(0, 5),
                                                  ),
                                                ],
                                              ),
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: AppliColors.white,
                                                  hintText: '1000 F',
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(6.0),
                                                    borderSide: const BorderSide(color: AppliColors.blue),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(6.0),
                                                    borderSide: const BorderSide(color: AppliColors.blue),
                                                  ),
                                                  contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                                                  prefix: const Text('CFA ', style: TextStyle(color: AppliColors.black, fontWeight: FontWeight.w400, fontFamily: 'Poppins', fontSize: 16.0)),
                                                  prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
                                                ),
                                                onChanged: (value) {
                                                  if (value.isNotEmpty) {
                                                    enteredAmount = int.parse(value);
                                                  } else {
                                                    enteredAmount = 0;
                                                  }
                                                  // validateInputs();
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
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 20.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Durée :",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color: AppliColors.black,
                                                fontSize: 13,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            Container(
                                              decoration: const BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black12,
                                                    blurRadius: 6.0,
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
                                                    borderRadius: BorderRadius.circular(6.0),
                                                    borderSide: const BorderSide(color: AppliColors.blue),
                                                  ),
                                                  suffix: const Text(' mois', style: TextStyle(color: AppliColors.black, fontWeight: FontWeight.w400, fontFamily: 'Poppins', fontSize: 16.0)),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(6.0),
                                                    borderSide: const BorderSide(color: AppliColors.blue),
                                                  ),
                                                  contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 20.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Numéro de paiement :",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color: AppliColors.black,
                                                fontSize: 13,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            Container(
                                              decoration: const BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black12,
                                                    blurRadius: 6.0,
                                                    offset: Offset(0, 5),
                                                  ),
                                                ],
                                              ),
                                              child: TextFormField(
                                                controller: _controller,
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: AppliColors.white,
                                                  hintText: 'Mon Iphone 12',
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(6.0),
                                                    borderSide: const BorderSide(color: AppliColors.blue),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(6.0),
                                                    borderSide: const BorderSide(color: AppliColors.blue),
                                                  ),
                                                  contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                                                ),
                                                validator: (value) {
                                                  if (value == null || value.trim().isEmpty) {
                                                    return "Veuillez renseigner votre nom";
                                                  }
                                                  return null;
                                                },
                                                onSaved: (value) => paymentNumber = _controller.text.trim(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                RadioListTile<OptionType>(
                                  value: OptionType.bloque,
                                  groupValue: _selectedOption,
                                  onChanged: (OptionType? value) {
                                    setState(() {
                                      _selectedOption = value;
                                    });
                                  },
                                  activeColor: AppliColors.black,
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
                                    setState(() {
                                      _selectedOption = value;
                                    });
                                  },
                                  activeColor: AppliColors.black,
                                  controlAffinity: ListTileControlAffinity.leading,
                                ),
                                SizedBox(
                                  width: 150,
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 38,
                                    child: ElevatedButton(
                                      onPressed: _submitForm,
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: const Color(0xFF005992),
                                        backgroundColor: AppliColors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: const Text(
                                        "Créer",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.bold,
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
                    ),
                  ),
                ],
              ),
            ),
          ),
          const MyFooter(),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation de suppression'),
          content: const Text('Êtes-vous sûr de vouloir supprimer tous les Pokémons ?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                context.read<PokemonsBloc>().add(DeleteAllPokemons());
                Navigator.of(context).pop(true);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
