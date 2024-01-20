import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../configurations/themes.dart';
import '../utils/extension/payment_type.dart';

class PaymentTypeSelectionWidget extends StatefulWidget {
  // final String uid;

  PaymentTypeSelectionWidget(
      // this.uid
      );

  @override
  _PaymentTypeSelectionWidgetState createState() => _PaymentTypeSelectionWidgetState();
}

class _PaymentTypeSelectionWidgetState extends State<PaymentTypeSelectionWidget> {
  final _formKey = GlobalKey<FormState>();
  late PaymentType paymentType;
  int enteredAmount = 200;
  String phoneNumber = '';

  @override
  void initState() {
    super.initState();
    paymentType = PaymentType.mtnMobileMoney;
    // print("l'id est ${widget.uid}");
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
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 20),
              color: AppliColors.mybackground,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
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
                      Text(
                        'Type de payement',
                        style: TextStyle(
                          fontSize: 23,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          color: AppliColors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Choisissez le type de paiement :',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      color: AppliColors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  buildImageContainer("assets/images/momo.jpg", PaymentType.mtnMobileMoney, 200, 110),
                  const SizedBox(height: 20),
                  buildImageContainer("assets/images/Moov_Africa_logo.png", PaymentType.moovMoney, 220, 110),
                  const SizedBox(height: 20),
                  buildImageContainer("assets/images/Celtiis-Benin.jpg", PaymentType.celtiisCash, 200, 110),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildImageContainer(String imagePath, PaymentType type, double width, double height) {
    return GestureDetector(
      onTap: () {
        setState(() {
          paymentType = type;
          showPaymentTypeDetailsModal(context, paymentType);
        });
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  String paymentTypeToString(PaymentType paymentType) {
    switch (paymentType) {
      case PaymentType.mtnMobileMoney:
        return 'MTN Mobile Money';
      case PaymentType.moovMoney:
        return 'Moov Money';
      case PaymentType.celtiisCash:
        return 'Celtiis Cash';
    }
  }

  void showPaymentTypeDetailsModal(BuildContext context, PaymentType paymentType) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  '${paymentTypeToString(paymentType)}',
                  style: TextStyle(
                    fontSize: 23,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    color: AppliColors.mybackground,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 20.0),
                child: PhysicalShape(
                  clipper: ShapeBorderClipper(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                  elevation: 16,
                  color: AppliColors.mybackground,
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Numéro ${paymentTypeToString(paymentType)} :',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: AppliColors.white,
                                          fontSize: 13,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Container(
                                          child: IntlPhoneField(
                                        initialCountryCode: "BJ",
                                        onChanged: (value) {
                                          phoneNumber = value.completeNumber;
                                        },
                                        decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.symmetric(
                                            vertical: 10.0,
                                            horizontal: 20.0,
                                          ),
                                          labelText: '99 00 00 00',
                                          hintText: 'Numéro de téléphone',
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                            borderSide: const BorderSide(
                                              color: AppliColors.transparent,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                            borderSide: const BorderSide(
                                              color: AppliColors.transparent,
                                            ),
                                          ),
                                          filled: true,
                                          fillColor: AppliColors.white,
                                        ),
                                      )),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
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
                                          color: AppliColors.white,
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
                          SizedBox(height: 20),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppliColors.white,
                              foregroundColor: AppliColors.mybackground,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Valider',
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
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
        );
      },
    );
  }

// void redirectToPaymentPage(PaymentType paymentType) {
//   Navigator.of(context).push(PageRouteBuilder(
//     pageBuilder: (context, animation, secondaryAnimation) {
//       return Stack(
//         children: [
//           SlideTransition(
//             position: Tween<Offset>(
//               begin: Offset.zero,
//               end: const Offset(-0.3, 0.0),
//             ).animate(animation),
//             child: PaymentTypeSelectionWidget(),
//           ),
//           SlideTransition(
//             position: Tween<Offset>(
//               begin: const Offset(1.0, 0.0),
//               end: Offset.zero,
//             ).animate(animation),
//             child: PaymentAmountPage(paymentType: paymentType),
//           ),
//         ],
//       );
//     },
//   ));
// }

  // String getPaymentTypeName(PaymentType paymentType) {
  //   // Retourner le nom du PaymentType en fonction de l'énumération
  //   // (par exemple, MTN Mobile Money, Celtiis Cash, Moov Money)
  // }
  //
  // String getPaymentTypeDescription(PaymentType paymentType) {
  //   // Retourner la description du PaymentType en fonction de l'énumération
  //   // (par exemple, "Portefeuille mobile MTN", "Portefeuille Celtiis Cash", "Portefeuille Moov")
  // }
}
