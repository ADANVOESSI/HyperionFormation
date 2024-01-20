import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:pinput/pinput.dart';

import '../configurations/themes.dart';
import '../provider/auth_provider.dart';

class PhoneRegisterScreen extends StatefulWidget {
  const PhoneRegisterScreen({super.key});

  @override
  State<PhoneRegisterScreen> createState() => _PhoneRegisterScreenState();
}

class _PhoneRegisterScreenState extends State<PhoneRegisterScreen> {
  bool otpCodeVisible = false;
  bool loading = false;
  bool resend = false;
  int count = 20;
  String verificationIDReceive = "";
  FirebaseAuth auth = FirebaseAuth.instance;
  String phoneNumber = '';
  String smsCode = "";
  final MyAuthProvider _authProvider = MyAuthProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppliColors.mybackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          iconSize: 28,
          icon: const Icon(
            Icons.arrow_back,
            color: AppliColors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          otpCodeVisible ? 'Code d\'authentification' : 'Connexion avec numéro',
          style: const TextStyle(
            fontSize: 22,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: AppliColors.mybackground,
              margin: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    otpCodeVisible ? "Verification OTP" : 'Restez Connecté',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 25,
                      color: AppliColors.white,
                    ),
                  ),
                  const SizedBox(height: 50),
                  Text(
                    otpCodeVisible
                        ? "Vous venez de recevoir un code sur votre numéro de téléphone. Veuillez le reseigner dans les cases ci-dessous pour continuer !"
                        : 'Entrez votre numéro de téléphone et cliquer sur <Vérifier> pour continuer !',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppliColors.white,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 50),
                  IntlPhoneField(
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
                  ),
                  Visibility(
                    visible: otpCodeVisible,
                    child: Column(
                      children: [
                        Pinput(
                          length: 6,
                          onChanged: (value) {
                            smsCode = value;
                            setState(() {});
                          },
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.center,
                          child: TextButton(
                            onPressed: () {},
                            // !resend ? null : onResendSmsCode,
                            child: Text(
                              !resend ? "00:${count.toString().padLeft(2, "0")}" : "Renvoyez le code",
                              style: const TextStyle(
                                fontSize: 15,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                                color: AppliColors.white,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: AppliColors.white,
                          backgroundColor: AppliColors.mybackground,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(color: AppliColors.white, width: 2),
                          ),
                        ),
                        onPressed: loading
                            ? null
                            : () {
                                if (otpCodeVisible) {
                                  _authProvider.onVerifySmsCode(verificationIDReceive: verificationIDReceive, smsCode: smsCode, context: context);
                                } else {
                                  verifyNumber();
                                }
                              },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Text(
                                otpCodeVisible ? "Se connecter" : "Vérifier",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (loading)
                                const Positioned.fill(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        const TextSpan(
                          text: "Vous n'avez pas de compte ? ",
                          style: TextStyle(
                            color: AppliColors.white,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            decoration: TextDecoration.underline,
                            decorationColor: AppliColors.white,
                          ),
                        ),
                        TextSpan(
                          text: 'Inscrivez-vous',
                          style: const TextStyle(
                            color: Color.fromARGB(255, 3, 248, 11),
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            decoration: TextDecoration.underline,
                            decorationColor: AppliColors.white,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).pushNamed('/inscription');
                            },
                        ),
                      ],
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

  void verifyNumber() {
    auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value) {});
      },
      verificationFailed: (FirebaseAuthException exception) {
        // print(exception.message);
      },
      codeSent: (String verificationId, int? forceResendingToken) {
        verificationIDReceive = verificationId;
        otpCodeVisible = true;
        setState(() {});
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
