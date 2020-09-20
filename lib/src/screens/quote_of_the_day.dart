import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class QuoteOfTheDay extends StatefulWidget {
  const QuoteOfTheDay({Key key, this.animationController}) : super(key: key);

  final AnimationController animationController;

  @override
  _QuoteOfTheDayState createState() => _QuoteOfTheDayState();
}

class _QuoteOfTheDayState extends State<QuoteOfTheDay>
    with TickerProviderStateMixin {
  Animation<double> topBarAnimation;

  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;
  String _quote;
  List<Color> _gradientColors = [
    const Color(0xfff44336),
    const Color(0xffba000d),
    const Color(0xff9c27b0),
    const Color(0xff6a0080),
    const Color(0xff2196f3),
    const Color(0xff0069c0),
    const Color(0xfffdd835),
    const Color(0xffc6a700)
  ];
  final _random = Random();
  Color _colorOne, _colorTwo;

  @override
  void initState() {
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController,
            curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));

    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (scrollController.offset <= 24 &&
          scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          setState(() {
            topBarOpacity = scrollController.offset / 24;
          });
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });
    super.initState();

    getQuote();
    _colorOne = _gradientColors[0];
    _colorTwo = _gradientColors[1];
  }

  Future<void> getQuote() async {
    var client = new http.Client();
    try {
      var queryLink = 'https://api.quotable.io/random';
      print(queryLink);
      var response = await client.get(queryLink);
       /* headers: {
          "Authorization": "Token 2b1c64c60a1f534e3783ce671b46acc9b05a0101",
          "language": "en",
        },
      );*/
      var parsed = json.decode(response.body);
      print(parsed);
      setState(() {
        _quote = parsed['content'] + "\n\nBy: " + parsed['author'];
        _gradientColors.shuffle(_random);
        _colorOne = _gradientColors[0];
        _colorTwo = _gradientColors[1];
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [_colorOne, _colorTwo]),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: _quote != null
                        ? Text('$_quote',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              color: Colors.white,
                              fontSize: 34.0,
                              height: 1.25,
                            ))
                        : CircularProgressIndicator(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      //floatingActionButton: FloatingActionButton(onPressed: , child: Icon(Icons.share)),
    );
  }
}
