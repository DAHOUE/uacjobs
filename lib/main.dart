import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:uac_mcf_project/HomeScreen.dart';
import 'package:uac_mcf_project/connexion.dart';
import 'package:uac_mcf_project/parser.dart';
import 'package:webfeed/domain/rss_feed.dart';
import 'package:webfeed/domain/rss_item.dart';

import 'homePage.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );

    return MaterialApp(
      title: 'UAC JOBS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: OnBoardingPage(),
    );
  }
}


class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  RssFeed rssFeed;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    parser();
  }

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => HomeScreen(rssFeed)),
    );
  }

  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset('assets/$assetName.jpg', width: 350.0),
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title:
              "Accroître la vibilité des opportunités à l'endroit des étudiants ou diplomés de l'UAC ",
          body: "",
          image: Image.asset(
            'assets/téléchargement.jpeg',
            fit: BoxFit.cover,
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Développer l'animation de la plateforme de l'UAC",
          body: "",
          image: Image.asset(
              'assets/développement-article-borne-escamotable.jpg',
              fit: BoxFit.cover),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title:
              "Offrir une expérience professionelle aux étudiants ou diplomés de l'UAC ",
          body: "",
          image: Image.asset(
              'assets/diplome-graduation-hat-isole-icone_25030-13391.jpg',
              fit: BoxFit.cover),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title:
              "Mettre en relation les enseignants avec les étudiants ou diplomeés de l'UAC",
          body: "",
          image: Image.asset(
              'assets/62770407-relations-humaines-3d-illustration-isolé-sur-fond-blanc.jpg',
              fit: BoxFit.cover),
          /*footer: RaisedButton(
            onPressed: () {
              introKey.currentState?.animateScroll(0);
            },
            child: const Text(
              'Relire',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.lightBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),*/
          decoration: pageDecoration,
        )
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text(
        'Ignorer',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Lancer',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          )),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }

  Future<Null> parser() async {
    RssFeed recu = await Parser().main();
    if (recu != null) {
      setState(() {
        rssFeed = recu;
        print(rssFeed.items.length);
        rssFeed.items.forEach((element) {
          RssItem rssItem = element;
        });
      });
    }
  }

}
