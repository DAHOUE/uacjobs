import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:multilevel_drawer/multilevel_drawer.dart';
import 'package:uac_mcf_project/connexion.dart';
import 'package:uac_mcf_project/constante/TextWithStyle.dart';
import 'package:uac_mcf_project/detailActuality.dart';
import 'package:webfeed/domain/rss_feed.dart';
import 'package:webfeed/domain/rss_item.dart';


import 'Models/Destination.dart';
import 'Models/Menu.dart';
import 'constante/date_convertisseur.dart';
import 'homePage.dart';
import 'opportunity.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  RssFeed rssFeed;
  HomeScreen(RssFeed rssFeed){
    this.rssFeed = rssFeed;
  }

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>  with SingleTickerProviderStateMixin{
  int _index = 0;
  int _selectedIndex = 0;

  Animation<double> _animation;
  AnimationController _animationController;
  RssFeed rssFeed;

  List<Menu> elementsMenu = [
    //new Menu('Appui financier', 'assets/Icones/icons8_receive_cash_100px.png'),
    //new Menu('Marché', 'assets/Icones/icons8_shopping_cart_100px.png'),
    new Menu(
        'Profil', 'assets/icones/baseline_account_circle_black_18dp.png'),
    new Menu('Informations', 'assets/icones/baseline_developer_board_white_18dp.png'),
    //new Menu('Opportunités', 'assets/Icones/icons8_pineapple_60px.png'),
    new Menu('Opportunités', 'assets/icones/baseline_flight_white_18dp.png'),
    //new Menu('Forum', 'assets/Icones/icons8_comment_discussion_100px.png'),
    new Menu('FAQ', 'assets/icones/baseline_help_white_18dp.png'),
    new Menu('Nous contacter',
        'assets/icones/baseline_contactless_white_18dp.png'),
    new Menu('Quitter', 'assets/icones/baseline_clear_white_18dp.png'),
  ];
  String elementMenuChoisi;



  @override
  void initState(){

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation = CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Accueil'),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.notifications,
                    size: 30,
                  )
                ],
              ),
            ),
          ],
        ),
        /*drawer: new Drawer(
          child: new Container(
            //color: Colors.grey[900],
            child: new ListView.builder(
                itemCount: elementsMenu.length,
                itemBuilder: (context, i) {
                  if (i == 0) {
                    return Center(
                      child: DrawerHeader(
                        //color: Colors.white,
                        child: Image.asset('assets/mcf_uac.png'),
                      ),
                    );
                  } else {
                    return new ListTile(
                      title: new Text(
                        elementsMenu[i].nom,
                        textScaleFactor: 1.5,
                        style: new TextStyle(
                        ),
                      ),
                      leading: new Image.asset(
                        elementsMenu[i].iconePATH,
                        fit: BoxFit.cover,
                        color: Colors.black,
                      ),
                      onTap: () {
                        elementMenuChoisi = elementsMenu[i].nom;
                        if (elementMenuChoisi == "Accueil") {
                          Navigator.pushReplacement(context,
                              new MaterialPageRoute(
                                  builder: (BuildContext buildContext) {
                                   // return HomeScreen(rssFeed);
                                  }));
                        } else {
                          Navigator.pop(context);
                        }
                      },
                    );
                  }
                }),
          ),
        ),*/

        drawer: MultiLevelDrawer(
          backgroundColor: Colors.white,
          rippleColor: Colors.white,
          subMenuBackgroundColor: Colors.grey.shade100,
          divisionColor: Colors.grey,
          header: Container(
            color: Colors.white24,
            height: MediaQuery.of(context).size.height * 0.25,
            child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "assets/mcf_uac.png",
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text("JOBS UAC", style: TextStyle(color: Colors.black,))
                  ],
                )),
          ),
          children: [
            MLMenuItem(
                leading: Icon(Icons.playlist_add_check),
                trailing: Icon(Icons.arrow_right),
                content: Text(
                  "Actualités",
                ),
                subMenuItems: [
                  MLSubmenu(
                      onClick: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(rssFeed)));
                      },
                      submenuContent: Text("Renseigner")),
                  MLSubmenu(onClick: () {}, submenuContent: Text("Supprimer")),
                  //MLSubmenu(onClick: () {}, submenuContent: Text("Option 3")),
                ],
                onClick: () {}),
            MLMenuItem(
                leading: Icon(Icons.add_to_drive),
                trailing: Icon(Icons.arrow_right),
                content: Text("Opportunités"),
                onClick: () {},
                subMenuItems: [
                  MLSubmenu(onClick: () {}, submenuContent: Text("Stage")),
                  MLSubmenu(onClick: () {}, submenuContent: Text("Emploi"))]),

            MLMenuItem(
                leading: Icon(Icons.payment),
                trailing: Icon(Icons.arrow_right),
                content: Text(
                  "News letters",
                ),
                subMenuItems: [
                  MLSubmenu(onClick: () {}, submenuContent: Text("Ajouter")),
                  MLSubmenu(onClick: () {}, submenuContent: Text("Editer")),
                ],
                onClick: () {}),
            MLMenuItem(
              leading: Icon(Icons.notifications),
              content: Text("Blogs"),
              onClick: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(rssFeed)));
              },
            ),
            MLMenuItem(
                leading: Icon(Icons.question_answer),
                content: Text(
                  "FAQ",
                ),
                onClick: () {}),
            MLMenuItem(
                leading: Icon(Icons.call),
                content: Text(
                  "Nous contacter",
                ),
                onClick: () {}),
            MLMenuItem(
                leading: Icon(Icons.close),
                content: Text(
                  "Quitter",
                ),
                onClick: () {}),
          ],
        ),

        body: ListView.builder(

            itemCount: widget.rssFeed.items.length,
            itemBuilder: (context, i){
              RssItem item = widget.rssFeed.items[i];
              return new Container(
                padding: EdgeInsets.all(10.0),

                child: new Card(
                    elevation: 10.0,
                    child: new Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[

                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                              children: <Widget>[

                                new Text('Actualité ${i+1} ', style: TextStyle(fontWeight: FontWeight.bold),),
                                new Text(new DateConvertisseur().convertirDate(item.pubDate.toString()), style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
                              ],
                            ),
                          ),
                          new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                new Card(
                                  child: new Container(
                                    height: MediaQuery.of(context).size.width / 2.5,
                                    width: MediaQuery.of(context).size.width / 2.5,
                                    child: new Image.network(item.enclosure.url, fit: BoxFit.fill),
                                  ),
                                ),
                                new Container(
                                  width: MediaQuery.of(context).size.width / 2.5,

                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      new Text((item.title) != null ? item.title : 'Texte Indisppnible'),
                                      RaisedButton(
                                        color: Colors.green,
                                          onPressed: (){
                                            Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
                                          return new DetailActuality(item);}));
                                          },
                                        child: TextWithStyle('Lire plus', color: Colors.white, fontWeight: FontWeight.bold,),
                                      ),
                                    ],
                                  )

                                )

                              ]

                          ),
                        ],
                      ),
                    )
              );
            }),

        /**
         * menu vertical
         */
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

          //Init Floating Action Bubble
          floatingActionButton: FloatingActionBubble(
            // Menu items
            items: <Bubble>[

              // Floating action menu item
              Bubble(
                title:"Etudiant",
                iconColor :Colors.white,
                bubbleColor : Colors.green,
                icon:Icons.edit,
                titleStyle:TextStyle(fontSize: 16 , color: Colors.white),
                onPress: () {
                  Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => Connexion(userType: 'Etudiant')));
                  _animationController.reverse();
                },
              ),
              // Floating action menu item
              Bubble(
                title:"Recruteur",
                iconColor :Colors.white,
                bubbleColor : Colors.green,
                icon:Icons.people,
                titleStyle:TextStyle(fontSize: 16 , color: Colors.white),
                onPress: () {
                  Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => Connexion(userType: 'Recruteur',)));
                  _animationController.reverse();
                },
              ),
              //Floating action menu item
              Bubble(
                title:"Animateur",
                iconColor :Colors.white,
                bubbleColor : Colors.green,
                icon:Icons.home,
                titleStyle:TextStyle(fontSize: 16 , color: Colors.white),
                onPress: () {
                  Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => Connexion(userType: 'Animateur',)));
                  _animationController.reverse();
                },
              ),
            ],

            // animation controller
            animation: _animation,

            // On pressed change animation state
            onPress: () => _animationController.isCompleted
                ? _animationController.reverse()
                : _animationController.forward(),

            // Floating Action button Icon color
            iconColor: Colors.white,

            // Flaoting Action button Icon

            iconData: _animationController.isDismissed  ? Icons.menu_outlined : Icons.close,
            backGroundColor: Colors.green,
          ),

        /*bottomNavigationBar: Container(
          //padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white54,
            borderRadius: BorderRadius.circular(30),
          ),
          child: GNav(
            gap: 8,
            activeColor: Colors.white,
            color: Colors.white,
            backgroundColor: Colors.green,
            iconSize: 25,
            padding: EdgeInsets.all(5),
            duration: Duration(milliseconds: 800),
            tabBackgroundColor: Colors.green,
            tabs: [
              GButton(
                icon: Icons.home,
                text: 'home',
              ),
              GButton(
                icon: Icons.favorite_border,
                text: 'Opportunités',
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => Opportunity()));
                },
              ),
              GButton(
                icon: Icons.map,
                text: 'Partenaires',
              ),
              GButton(
                icon: Icons.person_outline,
                text: 'Profile',
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),*/
      ),
    );
  }
}

class Activite {
  String nom;
  IconData icone;

  Activite(String nom, IconData icone) {
    this.nom = nom;
    this.icone = icone;
  }
}

class Chargement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Center(
      /*child: new TextAvecStyle('Chargement en cours ...',
        fontSize: 30.0,
        fontStyle: FontStyle.italic,),*/
        child: Container(
          height: 50,
          width: 50,
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation(Colors.green),
            strokeWidth: 6,

            //semanticsValue: '20%',
          ),
        ));
  }
}


