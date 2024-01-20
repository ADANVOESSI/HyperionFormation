import 'package:flutter/material.dart';

class LogoImage extends StatefulWidget {
  const LogoImage({super.key});

  @override
  State<LogoImage> createState() => _LogoImageState();
}

class _LogoImageState extends State<LogoImage> {
  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      backgroundImage: AssetImage('assets/images/imgA.jpg'),
      radius: 20,
    );
  }
}
