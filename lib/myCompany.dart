
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uac_mcf_project/HomeScreen.dart';
import 'package:uac_mcf_project/connexion.dart';
import 'package:uac_mcf_project/constante/TextWithStyle.dart';
import 'package:uac_mcf_project/homeConnexion.dart';
import 'package:uac_mcf_project/inscription.dart';


class MyCompany extends StatefulWidget {
  MyCompany({Key key, @required this.nom, @required this.prenom, @required this.ville, @required this.codePostal, @required this.statut, @required this.telephone, @required this.userType}) : super(key: key);
  final String userType;
  String nom;
  String prenom;
  String ville;
  String codePostal;
  Statut selectedUser;
  String statut;
  String telephone;

  @override
  _MyCompany createState() => _MyCompany();
}

enum SingingCharacter { Monsieur, Madame }

SingingCharacter _character = SingingCharacter.Monsieur;

class _MyCompany extends State<MyCompany> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  String nomCompany;
  String ifuCompany;
  String registreCompany;
  String raisonCompany;
  String villeCompany;
  String codePostalCompany;
  Statut selectedUser;
  String statut;
  String date = "1998/12/15";
  int _nombre_de_jours;




  @override
  void initState() {


  }

  @override
  Widget build(BuildContext context) {


    return new GestureDetector(
        onTap: (() => FocusScope.of(context).requestFocus(new FocusNode())),
        child: new Scaffold(
            body: new SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /*new Image.asset(
                        "assets/ADMIN-APPROVED-USER-REGISTRATION.png",
                        color: Colors.green,
                        fit: BoxFit.fill,
                        height: MediaQuery.of(context).size.width / 2,
                      ),*/
                      SizedBox(height: 10.0,),
                      new TextWithStyle(
                        "Identité de l'entreprise",
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      new Form(
                          key: _formKey,
                          child: new Column(
                            children: [

                              SizedBox(
                                height: 10.0,
                              ),

                              SizedBox(height: 10.0,),

                              new TextFormField(
                                //controller: pswController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                  prefixIcon: Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          start: 5.0),
                                      child: new Icon(Icons.account_box_outlined)
                                  ),
                                  labelText: 'IFU de l\'entreprise',
                                  labelStyle: new TextStyle(
                                      fontWeight: FontWeight.bold),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0)),
                                ),
                                // ignore: missing_return
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return "Entrez IFU de votre entreprise";
                                  } else
                                    return null;
                                },
                                onChanged: (val) {
                                  setState(() {
                                    ifuCompany = val;
                                  });
                                },
                              ),

                              SizedBox(height: 10.0,),

                              new TextFormField(
                                //controller: pswController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                  prefixIcon: Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          start: 5.0),
                                      child: new Icon(Icons.account_box_outlined)
                                  ),
                                  labelText: 'Nom de l\'entreprise',
                                  labelStyle: new TextStyle(
                                      fontWeight: FontWeight.bold),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0)),
                                ),
                                // ignore: missing_return
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return "Entrez votre entreprise";
                                  } else
                                    return null;
                                },
                                onChanged: (val) {
                                  setState(() {
                                    nomCompany = val;
                                  });
                                },
                              ),
                              SizedBox(height: 10.0,),

                              new TextFormField(
                                //controller: pswController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                  prefixIcon: Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                        start: 5.0),
                                    child: Icon(Icons.location_city),
                                  ),
                                  labelText: "Ville de l'entreprise",
                                  labelStyle: new TextStyle(
                                      fontWeight: FontWeight.bold),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0)),
                                ),
                                // ignore: missing_return
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return "Entrez votre ville";
                                  } else
                                    return null;
                                },
                                onChanged: (val) {
                                  setState(() {
                                    villeCompany = val;
                                  });
                                },
                              ),
                              SizedBox(height: 10.0,),

                              new TextFormField(
                                //controller: telephoneController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                  prefixIcon: Padding(
                                    padding:
                                    const EdgeInsetsDirectional.only(start: 5.0),
                                    child: SizedBox(
                                      child: CountryCodePicker(
                                        onChanged: (e) => print(e.toLongString()),
                                        initialSelection: 'BJ',
                                        showCountryOnly: true,
                                        showOnlyCountryWhenClosed: false,
                                        favorite: ['+229', 'BJ'],
                                      ),
                                    ),
                                  ),
                                  labelText: 'Contact entreprise',
                                  labelStyle: new TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                  hintText: "94170440",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0)),
                                ),
                                // ignore: missing_return
                                validator: (valeur) {
                                  if (valeur.isEmpty) {
                                    return 'Entrez contact entreprise' ;
                                  } else if (valeur.length < 8) {
                                    return 'Saisir un numéo valide';
                                  } else
                                    return null;
                                },
                                textInputAction: TextInputAction.next,
                              ),

                              SizedBox(height: 10,),

                              /*new TextFormField(
                                //controller: pswController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                  prefixIcon: Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                        start: 5.0),
                                    child: new Icon(Icons.account_box_rounded),
                                  ),
                                  labelText: 'Code postal',
                                  labelStyle: new TextStyle(
                                      fontWeight: FontWeight.bold),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0)),
                                ),
                                // ignore: missing_return
                                validator: (val) {
                                  if (val.isEmpty) {
                                    "Entrez votre code postal";
                                  } else
                                    return null;
                                },
                                onChanged: (val) {
                                  setState(() {
                                    codePostal = val;
                                  });
                                },
                              ),*/

                              SizedBox(
                                height: 10.0,
                              ),

                              new TextFormField(
                                //controller: pswController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                  prefixIcon: Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          start: 5.0),
                                      child: new Icon(Icons.account_box_outlined)
                                  ),
                                  labelText: 'Registre de commerce',
                                  labelStyle: new TextStyle(
                                      fontWeight: FontWeight.bold),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0)),
                                ),
                                // ignore: missing_return
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return "Entrez registre";
                                  } else
                                    return null;
                                },
                                onChanged: (val) {
                                  setState(() {
                                    registreCompany = val;
                                  });
                                },
                              ),

                              SizedBox(height: 10.0,),

                              new TextFormField(
                                //controller: pswController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                  prefixIcon: Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          start: 5.0),
                                      child: new Icon(Icons.account_box_outlined)
                                  ),
                                  labelText: 'Raison sociale de l\'entreprise',
                                  labelStyle: new TextStyle(
                                      fontWeight: FontWeight.bold),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0)),
                                ),
                                // ignore: missing_return
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return "Entrez raison sociale";
                                  } else
                                    return null;
                                },
                                onChanged: (val) {
                                  setState(() {
                                    raisonCompany = val;
                                  });
                                },
                              ),

                              SizedBox(
                                height: 10.0,
                              ),

                              new Material(
                                  elevation: 5.0,
                                  //borderRadius: BorderRadius.circular(30.0),
                                  //color: Color(0xff01A0C7),
                                  color: Colors.green,
                                  child: MaterialButton(
                                    minWidth: MediaQuery.of(context).size.width,
                                    padding:
                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                    onPressed: () {
                                      if (_formKey.currentState.validate()) {
                                        Navigator.push(context,
                                            new MaterialPageRoute(builder: (BuildContext context) {
                                              return HomeConnexion(nom: widget.nom, prenom: widget.prenom, codePostal: widget.codePostal,dateNaissance: date, telephone: widget.telephone, ville: widget.ville, statut: widget.statut, userType: widget.userType,);
                                            }));
                                      } else {
                                        print('Error');
                                      }
                                    },
                                    child: Text(
                                      "Enregistrer",
                                      textAlign: TextAlign.center,
                                      style: style.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )),
                            ],
                          )),
                    ]),
              ),
            )));
  }

  /*Future<Null> montrerDate() async{
    DateTime choix = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(1900),
      lastDate: new DateTime.now(),
      initialDatePickerMode: DatePickerMode.year,

    );
    if(choix != null){
      var difference = new DateTime.now().difference(choix);
      var jours = difference.inDays;
      var ans = (jours / 365);
      setState(() {
        _nombre_de_jours= jours;
        dateTimechoisie = choix;
      });
    }
  }*/

}

class  Statut {
  const Statut( this.name, this.icon);
  final String name;
  final Icon icon;
}



