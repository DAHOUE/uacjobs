
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uac_mcf_project/HomeScreen.dart';
import 'package:uac_mcf_project/constante/TextWithStyle.dart';
import 'package:uac_mcf_project/facebookSignIn.dart';
import 'package:uac_mcf_project/googleSignIn.dart';
import 'package:uac_mcf_project/inscription.dart';
import 'package:uac_mcf_project/myIdentity.dart';
import 'package:uac_mcf_project/parser.dart';
import 'package:uac_mcf_project/pinCodeVerificationScreen.dart';
import 'package:uac_mcf_project/statut_inscription.dart';
import 'package:webfeed/domain/rss_feed.dart';
import 'package:webfeed/domain/rss_item.dart';
import 'package:http/http.dart' as http;

import 'homeConnexion.dart';
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';

import 'dart:async';
import 'dart:convert' show json;

import "package:http/http.dart" as http;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);



class Connexion extends StatefulWidget {
  Connexion({Key key, @required this.userType}) : super(key: key);
  final String userType;

  @override
  _Connexion createState() => _Connexion();
}

class _Connexion extends State<Connexion> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final _formKey = GlobalKey<FormState>();

  GoogleSignInAccount _currentUser;
  String _contactText;



  String email;
  String password;
  bool _passwordVisible;
  RssFeed rssFeed;

  @override
  // ignore: must_call_super
  void initState() {

    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        _handleGetContact();
      }
    });
    _googleSignIn.signInSilently();

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
                padding: const EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 10.0),
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
                                  new TextButton(
                                      onPressed: (){
                                        versPageInscription('etudiant');
                                      },
                                      child: new TextWithStyle(
                                        'Mot de passe oublié',
                                        fontSize: 17.0,
                                        color: Colors.green,
                                      )
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 18.0,
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

                                        loginData();
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
                                  new TextButton(
                                      onPressed: (){
                                        Navigator.push(context, 
                                        MaterialPageRoute(builder: (BuildContext context){
                                          return StatutInscription();
                                        }));
                                      },
                                      child: new TextWithStyle(
                                        'S\'inscrire',
                                        fontSize: 17.0,
                                        color: Colors.green,
                                      )
                                  )
                                ],
                              ) : SizedBox(),
                              widget.userType != 'Animateur'? TextWithStyle('OU') : SizedBox(),
                              SizedBox(height: 10,),
                              widget.userType != 'Animateur'? new Material(
                                  elevation: 5.0,
                                  //borderRadius: BorderRadius.circular(30.0),
                                  //color: Color(0xff01A0C7),
                                  color: Colors.red,
                                  child: MaterialButton(
                                    minWidth: MediaQuery.of(context).size.width,
                                    padding:
                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                    onPressed: () {
                                      _handleSignIn();
                                    },
                                    child: Text(
                                      "Avec Compte Google",
                                      textAlign: TextAlign.center,
                                      style: style.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )) : SizedBox(),
                              /*new Material(
                                  elevation: 5.0,
                                  //borderRadius: BorderRadius.circular(30.0),
                                  //color: Color(0xff01A0C7),
                                  color: Colors.blue,
                                  child: MaterialButton(
                                    minWidth: MediaQuery.of(context).size.width,
                                    padding:
                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                    onPressed: () {
                                      Navigator.push(context,
                                          new MaterialPageRoute(builder: (BuildContext context) {
                                            return FacebookSignIn();
                                          }));
                                    },
                                    child: Text(
                                      "Compte Facebook",
                                      textAlign: TextAlign.center,
                                      style: style.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )),*/
                            ],
                          )),
                    ]),
              ),
            )));
  }

  /// API pour se connecter avec son compte Google
  Future<void> _handleGetContact() async {
    setState(() {
      _contactText = "Loading contact info...";
    });
    final http.Response response = await http.get(
      'https://people.googleapis.com/v1/people/me/connections'
          '?requestMask.includeField=person.names',
      headers: await _currentUser.authHeaders,
    );
    if (response.statusCode != 200) {
      setState(() {
        _contactText = "People API gave a ${response.statusCode} "
            "response. Check logs for details.";
      });
      print('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    final Map<String, dynamic> data = json.decode(response.body);
    final String namedContact = _pickFirstNamedContact(data);
    setState(() {
      if (namedContact != null) {
        _contactText = "I see you know $namedContact!";
      } else {
        _contactText = "No contacts to display.";
      }
    });
  }

  String _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic> connections = data['connections'];
    final Map<String, dynamic> contact = connections?.firstWhere(
          (dynamic contact) => contact['names'] != null,
      orElse: () => null,
    );
    if (contact != null) {
      final Map<String, dynamic> name = contact['names'].firstWhere(
            (dynamic name) => name['displayName'] != null,
        orElse: () => null,
      );
      if (name != null) {
        return name['displayName'];
      }
    }
    return null;
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
      Navigator.push(context, MaterialPageRoute(builder: (_) => HomeConnexion()));
    } catch (error) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => HomeConnexion()));
      print(error);
    }
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  Widget _buildBody() {
    if (_currentUser != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ListTile(
            leading: GoogleUserCircleAvatar(
              identity: _currentUser,
            ),
            title: Text(_currentUser.displayName ?? ''),
            subtitle: Text(_currentUser.email ?? ''),
          ),
          const Text("Signed in successfully."),
          Text(_contactText ?? ''),
          ElevatedButton(
            child: const Text('SIGN OUT'),
            onPressed: _handleSignOut,
          ),
          ElevatedButton(
            child: const Text('REFRESH'),
            onPressed: _handleGetContact,
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          const Text("You are not currently signed in."),
          ElevatedButton(
            child: const Text('SIGN IN'),
            onPressed: _handleSignIn,
          ),
        ],
      );
    }
  }



  void versPageInscription(String userType) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext context) {
          return Inscription(userType: userType);
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

  void loginData(){

    String url = 'http://192.168.8.104:8000/api/login';
    Map response;
    
    http.post(Uri.parse(url),
    headers: {
      'Accept': 'application/json'
    },
    body: {
      'email': email,
      'password': password,
    }).then((value) => {
      response = jsonDecode(value.body),

      if(response['success'] == true && response['data']['state'] == 'actif'){
        _save(response['token']),
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => HomeConnexion()))
      } else if(response['success'] == true && response['data']['state'] != 'actif')  {
        snackBar("Veuillez confirmer votre inscription"),
        sendEmailAgain()
      } else {
        snackBar("Email ou mot de passe incorrect. Ressayez SVP"),
      }
    });
  }

  void sendEmailAgain(){

    String url = "http://192.168.8.104:8000/api/sendEmail";

    Map response;
    http.post(Uri.parse(url),
    headers: {
      'Accept': 'application/json',
    },
    body: {
      'email': email
    }).then((value) => {

      response = jsonDecode(value.body),

      if(response['success'] == true){
        
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => PinCodeVerificationScreen(email, response['data']['code'])))
      } else{
        _showDialog("Veuillez vérifier votre connexion", "OK")
      }
    });
  }

  _save(String token) async{
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
  }

  void _showDialog(String msg, String msgButton){
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(msg),
          actions: <Widget>[
            TextButton(
              child: new Text(msgButton),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
     
  }

  // snackBar Widget
  snackBar(String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3),
      ),
    );
  }
}