import 'package:flutter/material.dart';
import 'package:uac_mcf_project/constante/TextWithStyle.dart';
import 'package:url_launcher/url_launcher.dart';


class DetailOpportunity extends StatefulWidget {
  final String titleOpportunity;

  DetailOpportunity({@required this.titleOpportunity});

  @override
  _DetailOpportunityState createState() => _DetailOpportunityState();
}
  class _DetailOpportunityState extends State<DetailOpportunity> {


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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text('Détails sur l\'opportunité'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: new SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(height: 60.0,),
              new TextWithStyle(widget.titleOpportunity),
              SizedBox(height: 30.0,),
              Row(
                children: [
                  new Text("Date limite:", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
                  new Text("19 février 2021",),
                ],
              ),
              SizedBox(height: 10.0,),
              new Card(

                child: new Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: new Image.asset("assets/Website-Banner-FR-1200x400.png", fit: BoxFit.fill,),
                ),
              ),
              FlatButton(
                color: Colors.green,
                onPressed: () {
                  launch_url();
                },
                child: TextWithStyle('Postuler en ligne', color: Colors.white, fontWeight: FontWeight.bold,),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                  ],
                ),
              ),
              new TextWithStyle("L’Initiative d’Ashinaga pour l’Afrique (IAA) est un programme international de "
                  "leadership visant à développer la prochaine génération de leaders qui pourront contribuer au développement de l’Afrique subsaharienne.Les boursiers de l’IAA sont des étudiants ayant perdu l’un ou les deux parents et sont engagés à retourner chez eux, ou tout du moins dans la région de l’Afrique subsaharienne, pour y amorcer le changement, l’innovation et le développement. L’IAA donne accès à un soutien financier complet pour étudier à l’université à l’international, y compris les frais de scolarité, de logement, de voyage et autres frais nécessaires."),
              FlatButton(
                onPressed: () {
                  launch_url1();
                },
                child: TextWithStyle('Aller sur le site', color: Colors.green, fontWeight: FontWeight.bold,),
              ),
            ],
          ),
        ),
      ),
    );
  }

  dynamic launch_url() async {
    const url = 'https://ashinaga.smapply.io/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  dynamic launch_url1() async {
    const url = 'https://en.ashinaga.org/candidatures/?lang=fr';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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