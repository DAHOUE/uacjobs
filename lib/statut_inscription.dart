import 'package:flutter/material.dart';
import 'package:uac_mcf_project/inscription.dart';
import 'package:uac_mcf_project/pinCodeVerificationScreen.dart';

import 'constante/TextWithStyle.dart';

class StatutInscription extends StatefulWidget {
  const StatutInscription({ Key key }) : super(key: key);

  @override
  _StatutInscriptionState createState() => _StatutInscriptionState();
}

class _StatutInscriptionState extends State<StatutInscription> {

    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
        onTap: (() => FocusScope.of(context).requestFocus(new FocusNode())),
        child: new Scaffold(
            body: 
              Padding(
                padding: const EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 10.0),
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
                        "S'inscrire en tant que: ",
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                                               Material(
                                  elevation: 5.0,
                                  //borderRadius: BorderRadius.circular(30.0),
                                  //color: Color(0xff01A0C7),
                                  color: Colors.red,
                                  child: MaterialButton(
                                    minWidth: MediaQuery.of(context).size.width * 0.30,
                                    height: MediaQuery.of(context).size.width * 0.20,
                                    //padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                    onPressed: () {
                                      versPageInscription('etudiant');
                                      },
                                    
                                    child: Text(
                                      "Etudiant",
                                      textAlign: TextAlign.center,
                                      style: style.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                      )),
                      SizedBox(width: 10.0,),
                      Material(
                                  elevation: 5.0,
                                  //borderRadius: BorderRadius.circular(30.0),
                                  //color: Color(0xff01A0C7),
                                  color: Colors.pink,
                                  child: MaterialButton(
                        minWidth: MediaQuery.of(context).size.width * 0.30,
                        height: MediaQuery.of(context).size.width * 0.20,
                                    //padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        onPressed: () => versPageInscription('recruteur'),
                      child: Text(
                                      "Recruteur",
                                      textAlign: TextAlign.center,
                                      style: style.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                      ))
                        ],
                      )
                              
                      ]),
              ),
            
        )
    );
 
  }

  void versPageInscription(String userType) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext context) {
          return new Inscription(userType: userType);
        }));
  }
}