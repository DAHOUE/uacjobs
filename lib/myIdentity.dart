
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uac_mcf_project/HomeScreen.dart';
import 'package:uac_mcf_project/connexion.dart';
import 'package:uac_mcf_project/constante/TextWithStyle.dart';
import 'package:uac_mcf_project/homeConnexion.dart';
import 'package:uac_mcf_project/inscription.dart';
import 'package:uac_mcf_project/myCompany.dart';


class MyIdentity extends StatefulWidget {
  MyIdentity({Key key, this.userType}) : super(key: key);
  final String userType;

  @override
  _MyIdentity createState() => _MyIdentity();
}

enum SingingCharacter { Monsieur, Madame }

SingingCharacter _character = SingingCharacter.Monsieur;

class _MyIdentity extends State<MyIdentity> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  String nom;
  String prenom;
  String ville;
  String codePostal;
  Statut selectedUser;
  String statut;
  String telephone;
  String dateNaissance;

  DateTime dateTimechoisie;
  int _nombre_de_jours;

  List<Statut> users = <Statut>[
    const Statut(
        'Monsieur',
        Icon(
          Icons.person,
        )),
    const Statut(
        'Madame',
        Icon(
          Icons.pregnant_woman_rounded,
        )),
  ];


  @override
  // ignore: must_call_super
  void initState() {


    nom = '';
    prenom = '';
    ville = '';
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
                        "Mon identité",
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
                              SizedBox(height: 10.0),
                              new TextFormField(
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
                                  labelText: 'Nom',
                                  labelStyle: new TextStyle(
                                      fontWeight: FontWeight.bold),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0)),
                                ),
                                // ignore: missing_return
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return "Entrez votre nom";
                                  } else
                                    return null;
                                },
                                onChanged: (val) {
                                  setState(() {
                                    nom = val;
                                  });
                                },
                              ),
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
                                  labelText: 'Prenom',
                                  labelStyle: new TextStyle(
                                      fontWeight: FontWeight.bold),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0)),
                                ),
                                // ignore: missing_return
                                validator: (val) {
                                  if (val.isEmpty) {
                                   return  "Entrez votre prenom";
                                  } else
                                    return null;
                                },
                                onChanged: (val) {
                                  setState(() {
                                    prenom = val;
                                  });
                                },
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              new Container(
                                child: DropdownButtonFormField<Statut>(
                                  validator: (val) => val == null
                                      ? "Sélectionnez votre civilité"
                                      : null,
                                  //value: selectedUser ?? users[0],
                                  decoration: InputDecoration(
                                    contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                    labelText: 'Civilité',
                                    hintText: 'Votre statut',
                                    labelStyle: new TextStyle(
                                        fontWeight: FontWeight.bold),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                  ),
                                  onChanged: (Statut Value) {
                                    setState(() {
                                      selectedUser = Value;
                                      statut = selectedUser.name;
                                    });
                                  },
                                  items: users.map((Statut user) {
                                    return DropdownMenuItem<Statut>(
                                      value: user,
                                      child: Row(
                                        children: <Widget>[
                                          user.icon,
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            user.name,
                                            style: TextStyle(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),

                              SizedBox(
                                height: 10.0,
                              ),

                              new TextFormField(
                                //controller: telephoneController,
                                onChanged: (val ){
                                  setState(() {
                                    telephone = val;
                                  });
                                },
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
                                  labelText: 'Téléphone',
                                  labelStyle: new TextStyle(
                                      color: Color.fromRGBO(23, 83, 8, 1),
                                      fontWeight: FontWeight.bold),
                                  hintText: "94170440",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0)),
                                ),
                                // ignore: missing_return
                                validator: (valeur) {
                                  if (valeur.isEmpty) {
                                    return 'Entrez votre numéro de téléphone';
                                  } else if (valeur.length < 8) {
                                    return 'Saisir un numéo valide';
                                  } else
                                    return null;
                                },
                                textInputAction: TextInputAction.next,
                              ),

                              SizedBox(height: 10.0,),
                              InkWell(
                                onTap: () {
                                  montrerDate();   // Call Function that has showDatePicker()
                                },
                                child: IgnorePointer(
                                  child: new TextFormField(
                                    onChanged: (val){
                                      setState(() {
                                        dateTimechoisie = val as DateTime;
                                        dateNaissance = dateTimechoisie.toString().substring(0, 10);
                                      });
                                    },
                                    decoration: InputDecoration(
                                        labelText: 'Date de naissance',
                                        labelStyle: new TextStyle(color: Color.fromRGBO(23, 83, 8, 1), fontWeight: FontWeight.bold),
                                        prefixIcon: Padding(
                                            padding: const EdgeInsetsDirectional.only(start: 10.0),
                                            child: new Row(
                                              children: [
                                                new Icon(Icons.date_range),
                                                SizedBox(width: 2.0,),
                                                new TextWithStyle((dateTimechoisie != null) ? dateTimechoisie.toString().substring(0, 10) : "Date de naissance", fontSize: 20.0)

                                              ],
                                            )
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15.0),
                                        )
                                    ),
                                  ),
                                ),
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
                                  labelText: 'Ville',
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
                                    ville = val;
                                  });
                                },
                              ),

                              SizedBox(height: 10,),

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
                                    return "Entrez votre code postal";
                                  } else
                                    return null;
                                },
                                onChanged: (val) {
                                  setState(() {
                                    codePostal = val;
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
                                              return widget.userType != 'Recruteur' ?
                                              HomeConnexion(nom: nom, prenom: prenom, dateNaissance: dateNaissance, codePostal: codePostal, telephone: telephone, ville: ville, statut: statut, userType: widget.userType,) :
                                              MyCompany(nom: nom, prenom: prenom, codePostal: codePostal, telephone: telephone, ville: ville, statut: statut, userType: widget.userType,);
                                            }));
                                      } else {
                                        print('Error');
                                      }
                                    },
                                    child: Text( widget.userType != 'Recruteur' ?
                                      "Enregistrer" : 'Suivant',
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

  Future<Null> montrerDate() async{
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
  }

}

class  Statut {
  const Statut( this.name, this.icon);
  final String name;
  final Icon icon;
}



