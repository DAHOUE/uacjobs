
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uac_mcf_project/HomeScreen.dart';
import 'package:uac_mcf_project/connexion.dart';
import 'package:uac_mcf_project/constante/TextWithStyle.dart';
import 'package:uac_mcf_project/inscription.dart';
import 'package:http/http.dart' as http;

import 'myIdentity.dart';


class Inscription extends StatefulWidget {
  Inscription({Key key, @required this.userType}) : super(key: key);
  final String userType;
  @override
  _Inscription createState() => _Inscription();
}

class _Inscription extends State<Inscription> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final _formKey = GlobalKey<FormState>();


  String email;
  String password;
  String password2;
  bool _passwordVisible;
  bool _passwordVisible2;


  @override
  // ignore: must_call_super
  void initState() {
    _passwordVisible = false;
    _passwordVisible2 = false;

    email = '';
    password = '';
    password2 = '';
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
                        fit: BoxFit.fill,
                        color: Colors.green,
                        height: MediaQuery.of(context).size.width / 2,
                      ),
                      new TextWithStyle(
                        "Inscription",
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
                                //controller: pswController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                  prefixIcon: Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                        start: 5.0),
                                    child: new Icon(Icons.email),
                                  ),
                                  labelText: 'Email',
                                  labelStyle: new TextStyle(
                                      fontWeight: FontWeight.bold),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0)),
                                ),
                                // ignore: missing_return
                                validator: (val) {
                                  if (RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(val)) {
                                    return null;
                                  } else
                                    return "Entrer une adresse valide";
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
                                // ignore: missing_return
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return "Entrez un mot de passe";
                                  } else if (val.length < 6) {
                                   return  "Entrer au moins 6 caractéres";
                                  } else
                                    return null;
                                },
                                onChanged: (val) {
                                  setState(() {
                                    password = val;
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
                                obscureText: !_passwordVisible2,
                                decoration: InputDecoration(
                                  contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                  prefixIcon: Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                        start: 5.0),
                                    child: new Icon(Icons.vpn_key)
                                  ),
                                  labelText: 'Confirmer mot de passe',
                                  labelStyle: new TextStyle(
                                      fontWeight: FontWeight.bold),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0)),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      // Based on passwordVisible state choose the icon
                                      _passwordVisible2
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      //color: Theme.of(context).primaryColorDark,
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
                                    password2 = val;
                                  });
                                },
                              ),
                              SizedBox(height: 20.0,),
                              Container(
                                child: Center(
                                  child: TextWithStyle('En continuant, vous acceptez les conditions générales de UAC Job',)
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              new Material(
                                  elevation: 5.0,
                                  //borderRadius: BorderRadius.circular(30.0),
                                  //color: Color(0xff01A0C7),
                                  color: Colors.green,
                                  child: MaterialButton(
                                    minWidth: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                    onPressed: () {
                                      if (_formKey.currentState.validate()) {
                                        if (password == password2) {
                                          userRegistration();
                                        } else {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return SimpleDialog(
                                                  contentPadding: EdgeInsets.all(20.0),
                                                  children: [
                                                    TextWithStyle(
                                                        'Les deux mots de passe sont non conforme')
                                                  ],
                                                );
                                              });
                                        }
                                      } else {
                                        print('Error');
                                      }
                                    },
                                    child: Text(
                                      "S'inscrire",
                                      textAlign: TextAlign.center,
                                      style: style.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )),
                              new Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  new TextWithStyle(
                                    'Déjà de compte?',
                                    color: Colors.black,
                                  ),
                                  new FlatButton(
                                      onPressed: versPageConnexion,
                                      child: new TextWithStyle(
                                        'Se connecter',
                                        fontSize: 17.0,
                                        color: Colors.green,
                                      )
                                  )
                                ],
                              )
                            ],
                          )),
                    ]),
              ),
            )
        )
    );
  }



  void versPageConnexion() {
    Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext context) {
          return new Connexion(userType: widget.userType,);
        }));
  }

  /*void versPageMotDePasseObliee() {
    Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext context) {
          return new Connexion();
        }));
  }*/

  void versPageIdentity(){
    Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext context){
      return new MyIdentity(userType: widget.userType,);
    } ));
  }

  Future userRegistration() async {
    // SERVER API URL
    var url = 'http://mestps.tech/uac_mcf.php';

    // Store all data with Param Name.

    var map = Map<String, dynamic>();
    map['action'] = "ADD_USER";
    map['email'] = email;
    map['password'] = password;

    var response = await http.post(url, body: json.encode(map));

    // Getting Server response into variable.
    var message = jsonDecode(response.body);

    // If Web call Success than Hide the CircularProgressIndicator.
    //if (response.statusCode == 200) {}

    // Showing Alert Dialog with Response JSON Message.
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(message),
          actions: <Widget>[
            message == 'Inscription effectuée avec succès'
                ? FlatButton(
              child: new Text("Se connecter"),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            Connexion(userType: widget.userType)));
              },
            )
                : FlatButton(
              child: new TextWithStyle("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

}