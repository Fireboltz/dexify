import 'package:dexify/src/app.dart';
import 'package:dexify/src/screens/quote_of_the_day.dart';
import 'package:dexify/traning/training_screen.dart';
import 'package:dexify/ui_view/emotion_detection.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_themes/dexify_app_theme.dart';
import 'bottom_navigation_view/bottom_bar_view.dart';
import 'models/tabIcon_data.dart';
import 'tracker/my_tracker.dart';

class DexifyAppHomeScreen extends StatefulWidget {
  @override
  _DexifyAppHomeScreenState createState() => _DexifyAppHomeScreenState();
}

class _DexifyAppHomeScreenState extends State<DexifyAppHomeScreen>
    with TickerProviderStateMixin {
  AnimationController animationController;

  SharedPreferences prefs;
  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: DexifyAppTheme.background,
  );

  @override
  void initState() {
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = LandingPage(animationController: animationController);
    super.initState();
    SharedPreferences.getInstance().then((pref) {
      setState(() => prefs = pref);
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: DexifyAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return Stack(
                children: <Widget>[
                  tabBody,
                  bottomBar(),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  var token = prefs.getString('token');
                  HttpLink httpLink = HttpLink(
                      uri: 'https://chapserver.herokuapp.com/');

                  ValueNotifier<GraphQLClient> client = ValueNotifier(
                    GraphQLClient(
                        cache: InMemoryCache(), link: httpLink),
                  );
                  return App(auth: token != null, client: client);
                },
              ),
            );
          },
          changeIndex: (int index) {
            if (index == 0) {
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      LandingPage(animationController: animationController);
                });
              });
            } else if (index == 1) {
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      QuoteOfTheDay(animationController: animationController);
                });
              });
            } else if (index == 2) {
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      EmotionDetectionScreen(animationController: animationController);
                });
              });
            }
            else {
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      TrainingScreen(animationController: animationController);
                });
              });
            }
          },
        ),
      ],
    );
  }
}
