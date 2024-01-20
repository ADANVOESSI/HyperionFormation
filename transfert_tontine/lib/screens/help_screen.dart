import 'package:flutter/material.dart';

import '../configurations/app_theme.dart';

class HelpScreen extends StatefulWidget {
  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return Container(
      color: isLightMode ? AppTheme.nearlyWhite : AppTheme.nearlyBlack,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: isLightMode ? AppTheme.nearlyWhite : AppTheme.nearlyBlack,
          body: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, left: 16, right: 16),
                child: Image.asset('assets/images/helpImage.png'),
              ),
              Container(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'Comment pouvons-nous vous aider ?',
                  style: TextStyle(
                    fontFamily: AppTheme.fontName,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isLightMode ? Colors.black : Colors.white,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  "Il semble que vous rencontriez des problèmes \navec notre système. Nous sommes là pour vous aider, alors contactez-nous",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: isLightMode ? Colors.black : Colors.white,
                    fontFamily: AppTheme.fontName,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Container(
                      width: 140,
                      height: 40,
                      decoration: BoxDecoration(
                        color: isLightMode ? Colors.blue : Colors.white,
                        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(color: Colors.grey.withOpacity(0.6), offset: const Offset(4, 4), blurRadius: 8.0),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {},
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                'Ecrivez-nous',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: isLightMode ? Colors.white : Colors.black,
                                  fontFamily: AppTheme.fontName,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
