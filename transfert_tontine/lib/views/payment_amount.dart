import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../configurations/themes.dart';
import '../utils/extension/payment_type.dart';

class PaymentAmountPage extends StatefulWidget {
  final PaymentType paymentType;
  const PaymentAmountPage({Key? key, required this.paymentType}) : super(key: key);

  @override
  _PaymentAmountPageState createState() => _PaymentAmountPageState(paymentType: paymentType);
}

class _PaymentAmountPageState extends State<PaymentAmountPage> {
  final _formKey = GlobalKey<FormState>();
  late final PaymentType paymentType;
  int enteredAmount = 200;
  String phoneNumber = '';

  _PaymentAmountPageState({required this.paymentType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppliColors.mybackground,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top,
          ),
          Column(
            children: [
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 20.0),
                    height: 35,
                    width: 40,
                    decoration: BoxDecoration(
                      color: AppliColors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: IconButton(
                      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 50.0, 0.0),
                      iconSize: 25.0,
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppliColors.mybackground,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  Text(
                    '${paymentTypeToString(paymentType)}',
                    style: TextStyle(
                      fontSize: 23,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      color: AppliColors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 20.0),
            child: PhysicalShape(
              clipper: ShapeBorderClipper(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
              elevation: 16,
              color: AppliColors.backgroundLight,
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 6),
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
                                      color: AppliColors.black,
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
                      SizedBox(height: 20),
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
                          backgroundColor: AppliColors.mybackground,
                          foregroundColor: AppliColors.white,
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
}
