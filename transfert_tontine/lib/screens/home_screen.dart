import 'package:flutter/material.dart';

import '../configurations/app_theme.dart';
import '../configurations/themes.dart';
import '../model/homelist.dart';
import '../provider/cards_provider.dart';
import '../views/cards/calendar_payment.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  CardProvider cardProvider = CardProvider();
  List<HomeList> homeList = [];
  AnimationController? animationController;
  bool multiple = true;

  @override
  void initState() {
    animationController = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);
    initHomeList();
    super.initState();
  }

  Future<void> initHomeList() async {
    Future<List<Map<String, dynamic>>>? userCards = cardProvider.fetchUserCards();

    List<Map<String, dynamic>> cardData = await userCards;

    setState(() {
      homeList = HomeList.fromSnapshotData(cardData);
    });
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 0));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return Scaffold(
      backgroundColor: isLightMode == true ? AppTheme.white : AppTheme.nearlyBlack,
      body: FutureBuilder<bool>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          } else {
            if (snapshot.data == true) {
              return Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    appBar(),
                    Expanded(
                      child: GridView(
                        padding: const EdgeInsets.only(top: 0, left: 12, right: 12),
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        children: List<Widget>.generate(
                          homeList.length,
                          (int index) {
                            final int count = homeList.length;
                            final Animation<double> animation = Tween<double>(begin: 0.0, end: 1.0).animate(
                              CurvedAnimation(
                                parent: animationController!,
                                curve: Interval((1 / count) * index, 1.0, curve: Curves.fastOutSlowIn),
                              ),
                            );
                            animationController?.forward();
                            return multiple
                                ? HomeListView(
                                    multiple: false,
                                    animation: animation,
                                    animationController: animationController!,
                                    listData: homeList[index],
                                    callBack: () {
                                      Navigator.push<dynamic>(
                                        context,
                                        MaterialPageRoute<dynamic>(
                                          builder: (BuildContext context) => homeList[index].navigateScreen!,
                                        ),
                                      );
                                    },
                                  )
                                : HomeListView(
                                    multiple: true,
                                    animation: animation,
                                    animationController: animationController!,
                                    listData: homeList[index],
                                    callBack: () {
                                      Navigator.push<dynamic>(
                                        context,
                                        MaterialPageRoute<dynamic>(
                                          builder: (BuildContext context) => homeList[index].navigateScreen!,
                                        ),
                                      );
                                    },
                                  );
                          },
                        ),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: multiple ? 2 : 1,
                          mainAxisSpacing: multiple ? 12.0 : 8,
                          crossAxisSpacing: multiple ? 12.0 : 0,
                          childAspectRatio: multiple ? 1.5 : 5,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                child: Center(
                  child: Text(
                    "Aucune donnée n'a été trouvée.",
                    style: TextStyle(
                      fontSize: 18,
                      color: AppliColors.black,
                    ),
                  ),
                ),
              );
            }
          }
        },
      ),
      floatingActionButton: InkWell(
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: AppliColors.mybackground,
            borderRadius: BorderRadius.circular(50.0),
          ),
          child: Icon(
            Icons.add,
            color: AppliColors.white,
            size: 38,
          ),
        ),
        onTap: () {
          Navigator.of(context).pushNamed('/createCards');
        },
      ),
    );
  }

  Widget appBar() {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return SizedBox(
      height: AppBar().preferredSize.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 8),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  'Transfert Tontine',
                  style: TextStyle(
                    fontSize: 22,
                    color: isLightMode ? AppTheme.darkText : AppTheme.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, right: 8),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
              color: isLightMode ? Colors.white : AppTheme.nearlyBlack,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(AppBar().preferredSize.height),
                  child: Icon(
                    multiple ? Icons.dashboard : Icons.view_agenda,
                    color: isLightMode ? AppTheme.dark_grey : AppTheme.white,
                  ),
                  onTap: () {
                    setState(() {
                      multiple = !multiple;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeListView extends StatelessWidget {
  const HomeListView({
    Key? key,
    required this.listData,
    required this.callBack,
    required this.animationController,
    required this.animation,
    required this.multiple,
  }) : super(key: key);

  final HomeList listData;
  final VoidCallback callBack;
  final AnimationController animationController;
  final Animation<double> animation;
  final bool multiple;

  @override
  Widget build(BuildContext context) {
    return multiple
        ? AnimatedBuilder(
            animation: animationController,
            builder: (BuildContext context, Widget? child) {
              return FadeTransition(
                opacity: animation,
                child: Transform(
                  transform: Matrix4.translationValues(0.0, 50 * (1.0 - animation.value), 0.0),
                  child: AspectRatio(
                    aspectRatio: 1.5,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: <Widget>[
                          Material(
                            color: AppliColors.mybackground,
                            child: InkWell(
                              splashColor: Colors.grey.withOpacity(0.2),
                              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                              onTap: callBack,
                              child: Container(
                                child: Card(
                                  color: AppliColors.backgroundLight,
                                  child: ListTile(
                                    leading: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: AppliColors.mybackground,
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      child: Text(
                                        listData.primaryText,
                                        style: TextStyle(
                                          color: AppliColors.white,
                                          fontSize: 20,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      listData.secondaryText,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: AppliColors.mybackground,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    subtitle: Text(
                                      listData.tertiaryText,
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
                                              echeance: listData.expired!,
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
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          )
        : AnimatedBuilder(
            animation: animationController,
            builder: (BuildContext context, Widget? child) {
              return FadeTransition(
                opacity: animation,
                child: Transform(
                  transform: Matrix4.translationValues(0.0, 50 * (1.0 - animation.value), 0.0),
                  child: AspectRatio(
                    aspectRatio: 1.5,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: <Widget>[
                          Material(
                            color: AppliColors.mybackground,
                            child: InkWell(
                              splashColor: Colors.grey.withOpacity(0.2),
                              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                              onTap: callBack,
                              child: Container(
                                child: Card(
                                  color: AppliColors.backgroundLight,
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
                                                listData.secondaryText,
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
                                                listData.primaryText,
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
                                                listData.tertiaryText,
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
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
  }
}
