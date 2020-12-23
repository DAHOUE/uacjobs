import 'package:flutter/material.dart';
import 'package:multilevel_drawer/multilevel_drawer.dart';
import 'package:uac_mcf_project/myIdentity.dart';
import 'package:uac_mcf_project/opportunity.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Models/Destination.dart';
import 'constante/TextWithStyle.dart';
import 'homePage.dart';




class HomeConnexion extends StatefulWidget {
  HomeConnexion({Key key, @required this.nom, @required this.prenom, @required this.ville, @required this.codePostal, @required this.statut, @required this.telephone, @required this.dateNaissance, @required this.userType}) : super(key: key);
  String nom;
  String prenom;
  String ville;
  String codePostal;
  String statut;
  String telephone;
  String dateNaissance;
  String userType;

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<HomeConnexion> with SingleTickerProviderStateMixin {

  Animation<double> _animation;
  AnimationController _animationController;

  List<Activite> mesActivites = [
    new Activite("Candidature à l’Initiative d’Ashinaga pour l’Afrique", Icons.directions_bike),
    new Activite("Candidature à l’Initiative d’Ashinaga pour l’Afrique", Icons.palette),
    new Activite("Candidature à l’Initiative d’Ashinaga pour l’Afrique", Icons.golf_course),
    new Activite("Candidature à l’Initiative d’Ashinaga pour l’Afrique", Icons.gamepad),
    new Activite("Candidature à l’Initiative d’Ashinaga pour l’Afrique", Icons.build),
    new Activite("Candidature à l’Initiative d’Ashinaga pour l’Afrique", Icons.directions_bike),
    new Activite("Candidature à l’Initiative d’Ashinaga pour l’Afrique", Icons.palette),
    new Activite("Candidature à l’Initiative d’Ashinaga pour l’Afrique", Icons.golf_course),
    new Activite("Candidature à l’Initiative d’Ashinaga pour l’Afrique", Icons.gamepad),
    new Activite("Candidature à l’Initiative d’Ashinaga pour l’Afrique", Icons.build),
    new Activite("Candidature à l’Initiative d’Ashinaga pour l’Afrique", Icons.directions_bike),
    new Activite("Candidature à l’Initiative d’Ashinaga pour l’Afrique", Icons.palette),
    new Activite("Candidature à l’Initiative d’Ashinaga pour l’Afrique", Icons.golf_course),
    new Activite("Candidature à l’Initiative d’Ashinaga pour l’Afrique", Icons.gamepad),
    new Activite("Candidature à l’Initiative d’Ashinaga pour l’Afrique", Icons.build),
  ];

  List<Entity> mesEntities = [
    new Entity("Mes préferences email", Icons.directions_bike, "http://www.ifri-uac.bj/"),
    new Entity("Mes offres", Icons.palette, "https://epac.uac.bj/"),
    new Entity("Recherche", Icons.search, "https://www.oreilleducampus.org/"),
    new Entity("Modifier mot de passe", Icons.golf_course, "https://cours.uac.bj/u/UyhNIEfzgPy1ZMJnzBsB/"),
    new Entity("Supprimer mon compte", Icons.gamepad, "http://www.ifri-uac.bj/"),
    new Entity("Mon identité", Icons.build, "http://www.ifri-uac.bj/"),


  ];
  int _index = 0;
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    final bucket = PageStorageBucket();
    _widgetOptions = <Widget>[
      PageStorage(
        bucket: bucket,
        child: GridView.builder(
            key: PageStorageKey<String>('0'),
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: mesEntities.length,
            itemBuilder: (context, i) {
              Entity entityChosen = mesEntities[i];
              return new Container(
                //padding: EdgeInsets.all(10.0),
                child: new Card(
                    elevation: 10.0,
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                         // new TextWithStyle(entityChosen.nom, fontWeight: FontWeight.bold,),
                          new  Expanded(
                            child: new Icon(mesEntities[i].icone, color: Colors.black, size: 65.0,),
                          ),
                          FlatButton(
                            onPressed: () {
                              launch_url();
                            },
                            child: TextWithStyle(mesEntities[i].nom, color: Colors.green, fontWeight: FontWeight.bold, fontSize: 20.0,),
                          ),
                        ],
                      ),
                ),
              );
            }),


      ),
      PageStorage(
        bucket: bucket,
        child: ListView.builder(

            itemCount: mesActivites.length,
            itemBuilder: (context, i){
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

                              Row(
                                children: [
                                  new Text("Date limite:", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
                                  new Text("19 février 2021",),
                                ],
                              ),
                              //new Text(new DateConvertisseur().convertirDate(item.pubDate.toString()), style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
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
                                  child: new Image.asset("assets/Website-Banner-FR-1200x400.png", fit: BoxFit.fill),
                                ),
                              ),
                              new Container(
                                  width: MediaQuery.of(context).size.width / 2.5,

                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      new Text(mesActivites[i].nom),
                                      RaisedButton(
                                        color: Colors.green,
                                        onPressed: (){
                                          Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
                                            return new DetailOpportunity(titleOpportunity: mesActivites[i].nom);}));
                                        },
                                        child: TextWithStyle('Détails', color: Colors.white, fontWeight: FontWeight.bold,),
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
      ),
      PageStorage(
        bucket: bucket,
        child: SingleChildScrollView(
          key: PageStorageKey<String>('2'),
          child:
            Column(
              key: PageStorageKey<String>('2'),
              children: <Widget>[
                Card(
                  //elevation: 10.0,
                  child: Container(
                    height: 220,
                    width: 220,
                    child: new Image.asset(
                      "assets/400149200417_6190.jpg",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(height: 15.0,),
                new TextWithStyle('Nom : ${widget.nom}', fontWeight: FontWeight.bold,),
                SizedBox(height: 5.0,),
                Divider(),
                SizedBox(height: 5.0,),
                new TextWithStyle('Prenom : ${widget.prenom}', fontWeight: FontWeight.bold,),
                SizedBox(height: 5.0,),
                Divider(),
                SizedBox(height: 5.0,),
                new TextWithStyle('Date de naissance : ${widget.dateNaissance}', fontWeight: FontWeight.bold,),
                SizedBox(height: 5.0,),
                Divider(),
                SizedBox(height: 5.0,),
                new TextWithStyle('Ville  : ${widget.ville}', fontWeight: FontWeight.bold,),
                SizedBox(height: 15.0,),
                Divider(),
                SizedBox(height: 5.0,),
                new TextWithStyle('Téléphone : ${widget.telephone}', fontWeight: FontWeight.bold,),
                SizedBox(height: 5.0,),
                Divider(),
                SizedBox(height: 15.0,),
                new TextWithStyle('Code postal : ${widget.codePostal}', fontWeight: FontWeight.bold,),
                RaisedButton(
                  color: Colors.green,
                  onPressed: (){
                    Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
                      return new MyIdentity(userType: widget.userType,);}));
                  },
                  child: TextWithStyle('Inscription', color: Colors.white, fontWeight: FontWeight.bold,),
                ),
              ],

            ),

        ),
      ),
    ];
  }



  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeConnexion()));
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
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeConnexion()));
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
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home', style: TextStyle(fontWeight: FontWeight.bold),),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school_sharp),
            title: Text('Opportunité', style: TextStyle(fontWeight: FontWeight.bold),)
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            title: Text('Profil', style: TextStyle(fontWeight: FontWeight.bold),)
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }

  // Lancer une URL
  dynamic launch_url() async {
    const url = 'https://elearning.etudiant.bj/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class Entity {
  String nom;
  IconData icone;
  String urlSite;

  Entity(String nom, IconData icone, String urlSite) {
    this.nom = nom;
    this.icone = icone;
    this.urlSite;
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
