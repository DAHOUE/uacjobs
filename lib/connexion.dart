
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uac_mcf_project/HomeScreen.dart';
import 'package:uac_mcf_project/constante/TextWithStyle.dart';
import 'package:uac_mcf_project/inscription.dart';
import 'package:uac_mcf_project/myIdentity.dart';
import 'package:uac_mcf_project/parser.dart';
import 'package:webfeed/domain/rss_feed.dart';
import 'package:webfeed/domain/rss_item.dart';
import 'package:http/http.dart' as http;

import 'homeConnexion.dart';


class Connexion extends StatefulWidget {
  Connexion({Key key, @required this.userType}) : super(key: key);
  final String userType;

  @override
  _Connexion createState() => _Connexion();
}

class _Connexion extends State<Connexion> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final _formKey = GlobalKey<FormState>();


  String email;
  String password;
  bool _passwordVisible;
  RssFeed rssFeed;

  @override
  // ignore: must_call_super
  void initState() {

    super.initState();
  parser();
  _passwordVisible = false;

    email = '';
    password = '';
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
                      new Image.asset(
                        "assets/ADMIN-APPROVED-USER-REGISTRATION.png",
                        color: Colors.green,
                        fit: BoxFit.fill,
                        height: MediaQuery.of(context).size.width / 2,
                      ),
                      new TextWithStyle(
                        "Connexion",
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      new Form(
                          key: _formKey,
                          //autovalidate: _autovalidate,
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
                                child: new Icon(Icons.email)
                              ),
                              hintText: 'isaac@gmail.com',
                              labelText: 'Email',
                              labelStyle: new TextStyle(
                                  fontWeight: FontWeight.bold),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                            ),
                            validator: (value) {
                              if (RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(value)) {
                                return null;
                              } else
                                return "Entrez une adresse valide";
                            },
                            onChanged: (val) {
                              setState(() {
                                email = val;
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
                                      fontWeight: FontWeight.bold),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0)),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      // Based on passwordVisible state choose the icon
                                      _passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      //color: Theme.of(context).primaryColorDark,
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
                                    // ignore: unnecessary_statements
                                    return "Entrer au moins 6 caractéres";
                                  } else
                                    return null;
                                },
                                onChanged: (val) {
                                  setState(() {
                                    password = val;
                                  });
                                },
                              ),
                              new Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  new FlatButton(
                                      onPressed: versPageInscription,
                                      child: new TextWithStyle(
                                        'Mot de passe oublié',
                                        fontSize: 17.0,
                                        color: Colors.green,
                                      )
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 45.0,
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
                                        userLogin();
                                      } else {
                                        print('Error');
                                      }
                                    },
                                    child: Text(
                                      "Se connecter",
                                      textAlign: TextAlign.center,
                                      style: style.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )),
                              widget.userType != 'Animateur'? new Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  new TextWithStyle(
                                    'Pas de compte ?',
                                    color: Colors.black,
                                  ),
                                  new FlatButton(
                                      onPressed: versPageInscription,
                                      child: new TextWithStyle(
                                        'S\'inscrire',
                                        fontSize: 17.0,
                                        color: Colors.green,
                                      )
                                  )
                                ],
                              ) : TextWithStyle('  ')
                            ],
                          )),
                    ]),
              ),
            )));
  }



  void versPageInscription() {
    Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext context) {
          return widget.userType != 'Etudiant' ? Inscription(userType: 'Recruteur',) : Inscription(userType: 'Etudiant');
        }));
  }

  /*void versPageMotDePasseObliee() {
    Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext context) {
          return new Inscription();
        }));
  }*/

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

  Future userLogin() async {
    // SERVER LOGIN API URL
    var url = 'http://mestps.tech/uac_mcf.php';

    // Store all data with Param Name.
    //var data = {'phone': phone, 'password': password};
    var map = Map<String, dynamic>();
    map['action'] = "LOGIN_USER";
    map['email'] = email;
    map['password'] = password;

    // Starting Web API Call.
    //var response = await http.post(url, body: json.encode(map));
    var response = await http.post(url, body: json.encode(map));

    // Getting Server response into variable.
    var message = jsonDecode(response.body);

    // If the Response Message is Matched.
    if (message == 'Login Matched') {
      // Navigate to Home.
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) => HomeConnexion(nom: null, prenom: null, ville: null, codePostal: null, statut: null, telephone: null, dateNaissance: null, userType: null)));
    } else {
      // Showing Alert Dialog with Response JSON Message.
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(message),
            actions: <Widget>[
              FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }


}