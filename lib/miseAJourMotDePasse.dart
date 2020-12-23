import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'connexion.dart';
import 'constante/TextWithStyle.dart';

class MiseAJourMotDePasse extends StatefulWidget {
  String email;
  MiseAJourMotDePasse({this.email});

  @override
  _MiseAJourMotDePasse createState() => _MiseAJourMotDePasse();
}

class _MiseAJourMotDePasse extends State<MiseAJourMotDePasse> {
  final _formKey = GlobalKey<FormState>();
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  String motDePasse;
  String motDePasse2;
  bool _passwordVisible;
  bool _passwordVisible2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _passwordVisible = false;
    _passwordVisible2 = false;
    motDePasse = '';
    motDePasse2 = '';
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 100.0,
                      ),
                      new Image.asset(
                        "assets/ADMIN-APPROVED-USER-REGISTRATION.png",
                        fit: BoxFit.fill,
                        height: MediaQuery.of(context).size.width / 2,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      new TextWithStyle(
                        "Saisir un nouveau mot de passe",
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                        color: Color.fromRGBO(23, 83, 8, 1),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      new Form(
                          key: _formKey,
                          child: new Column(
                            children: [
                              new TextFormField(
                                //controller: pswController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                obscureText: !_passwordVisible,
                                decoration: InputDecoration(
                                  contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                  prefixIcon: Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                        start: 5.0),
                                    child: new Icon(Icons.vpn_key),
                                  ),
                                  labelText: 'Mot de passe',
                                  labelStyle: new TextStyle(
                                      color: Color.fromRGBO(23, 83, 8, 1),
                                      fontWeight: FontWeight.bold),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0)),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      // Based on passwordVisible state choose the icon
                                      _passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Theme.of(context).primaryColorDark,
                                    ),
                                    onPressed: () {
                                      // Update the state i.e. toogle the state of passwordVisible variable
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                  ),
                                ),
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return "Entrez un mot de passe";
                                  } else if (val.length < 6) {
                                    return "Entrer au moins 6 caractéres";
                                  } else
                                    return null;
                                },
                                onChanged: (val) {
                                  setState(() {
                                    motDePasse = val;
                                  });
                                },
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              new TextFormField(
                                //controller: pswConfirmController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                obscureText: !_passwordVisible2,
                                decoration: InputDecoration(
                                  contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                  prefixIcon: Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                        start: 5.0),
                                    child: new Icon(Icons.vpn_key),
                                  ),
                                  labelText: 'Confirmez',
                                  labelStyle: new TextStyle(
                                      color: Color.fromRGBO(23, 83, 8, 1),
                                      fontWeight: FontWeight.bold),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0)),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      // Based on passwordVisible state choose the icon
                                      _passwordVisible2
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Theme.of(context).primaryColorDark,
                                    ),
                                    onPressed: () {
                                      // Update the state i.e. toogle the state of passwordVisible variable
                                      setState(() {
                                        _passwordVisible2 = !_passwordVisible2;
                                      });
                                    },
                                  ),
                                ),
                                // ignore: missing_return
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return "Entrez un mot de passe";
                                  } else if (val.length < 6) {
                                    return "Entrer au moins 6 caractéres";
                                  } else
                                    return null;
                                },
                                onChanged: (val) {
                                  setState(() {
                                    motDePasse2 = val;
                                  });
                                },
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              SizedBox(
                                height: 45.0,
                              ),
                              new Material(
                                  elevation: 5.0,
                                  borderRadius: BorderRadius.circular(30.0),
                                  //color: Color(0xff01A0C7),
                                  color: Color.fromRGBO(23, 83, 8, 1),
                                  child: MaterialButton(
                                    onPressed: () {
                                      if (_formKey.currentState.validate()) {
                                        if (motDePasse == motDePasse2) {
                                          nouveauMotDePasse();
                                        } else {
                                          return showDialog(
                                              barrierDismissible: true,
                                              context: context,
                                              builder: (BuildContext context) {
                                                return SimpleDialog(
                                                  children: [
                                                    TextWithStyle(
                                                        'Les deux mots de passe ne sont pas conformes')
                                                  ],
                                                );
                                              });
                                        }
                                      } else {
                                        print('error');
                                      }
                                    },
                                    minWidth: MediaQuery.of(context).size.width,
                                    padding:
                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                    //onPressed: versPageDeCodeVerification,
                                    child: Text(
                                      "Mettre à jour",
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

  /*
  fonction pour modifier le mot de passe
   */

  Future nouveauMotDePasse() async {
    //Server url api
    var url = 'http://mestps.tech/uac_mcf.php';

    //les données à envoyer dans la base
    var map = Map<String, dynamic>();
    map['action'] = 'RESET_motDePasse';
    map['email'] = widget.email;
    map['password'] = motDePasse;

    //l'envoi des donnés
    var response = await http.post(url, body: json.encode(map));

    //message à recevoir
    var message = jsonDecode(response.body);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return message == 'Ressayez Svp'
            ? showDialog(
            barrierDismissible: true,
            context: context,
            builder: (BuildContext context) {
              return SimpleDialog(
                children: [TextWithStyle(message)],
              );
            })
            : AlertDialog(
          contentPadding: EdgeInsets.only(
            top: 20.0,
          ),
          title: new TextWithStyle(message),
          actions: <Widget>[
            FlatButton(
              child: new Text("Se connecter"),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Connexion(userType: 'Edutiant')));
              },
            ),
          ],
        );
      },
    );
  }
}