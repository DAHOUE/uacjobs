import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:http/http.dart' as http;
import 'package:uac_mcf_project/constante/TextWithStyle.dart';

import 'miseAJourMotDePasse.dart';

class PageMotDePasseOubliee extends StatefulWidget {
  @override
  _PageMotDePasseOublie createState() => _PageMotDePasseOublie();
}

class _PageMotDePasseOublie extends State<PageMotDePasseOubliee> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email;

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    email = '';
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
                        "Mot de passe oublié",
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                        color: Color.fromRGBO(23, 83, 8, 1),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      new Form(
                          key: _formKey,
                          child: new Column(
                            children: [
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
                                height: 45.0,
                              ),
                              new Material(
                                  elevation: 5.0,
                                  borderRadius: BorderRadius.circular(30.0),
                                  //color: Color(0xff01A0C7),
                                  color: Color.fromRGBO(23, 83, 8, 1),
                                  child: MaterialButton(
                                    minWidth: MediaQuery.of(context).size.width,
                                    padding:
                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                    onPressed: () {
                                      if (_formKey.currentState.validate()) {
                                        rechercherUser();
                                      } else {
                                        print('Error');
                                      }
                                    },
                                    child: Text(
                                      "Valider",
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
  fonction pour rechercher un user dans la base de données
   */
  Future rechercherUser() async {
    //URL de l'API server
    var url = 'http://mestps.tech/uac_mcf.php';

    //Les données à envoyer vers la base de donnés
    var map = Map<String, dynamic>();
    map['action'] = "RESEACH_USER";
    map['email'] = email;

    //Reponse du serveur
    var response = await http.post(url, body: json.encode(map));

    //Message du corps de l'api
    var message = jsonDecode(response.body);

    if (message == "User Found") {
      Navigator.push(context, MaterialPageRoute(
        // ignore: non_constant_identifier_names
          builder: (BuildContext) {
            return MiseAJourMotDePasse();
          }));
    } else {
      return showDialog(
          barrierDismissible: true,
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(
              children: [
                TextWithStyle('Cette adresse email n\'a pas été enregistrée'),
              ],
            );
          });
    }
  }

//  void _sendSMS(String message, List<String> recipents) async {
//    String _result = await sendSMS(message: message, recipients: recipents)
//        .catchError((onError) {
//      print(onError);
//    });
//    //print(_result);
//  }
//  void _sendCode(String telephone)
//  {
//    //générer code aléatoire
//    var rng = new Random();
//    var l = new List.generate(4, (_) => rng.nextInt(10));
//    String message = l.toString();
//    List<String> recipents = ["$telephone"];
//
//    _sendSMS(message, recipents);
//  }

//  void _sendSMS(String message, List<String> recipents) async {
//    try {
//      String _result = await sendSMS(
//          message: message, recipients: recipents);
//      setState(() => _message = _result);
//    } catch (error) {
//      setState(() => _message = error.toString());
//    }
//  }

//  void _canSendSMS() async {
//    bool _result = await canSendSMS();
//    setState(() => _canSendSMSMessage =
//    _result ? 'This unit can send SMS' : 'This unit cannot send SMS');
//  }

//Productueur, commercant, exportateur, Structeur de finance
}