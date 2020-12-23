import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uac_mcf_project/HomeScreen.dart';
import 'package:uac_mcf_project/constante/TextWithStyle.dart';
import 'package:uac_mcf_project/homeConnexion.dart';


class SplashScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return StartState();
  }
}

class StartState extends State<SplashScreen>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  startTimer() async{
    var duration = Duration(seconds: 10);
    return Timer(duration, route);
  }

  route(){
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => HomeConnexion()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(23, 83, 8, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget> [
            Container(
              child: Image.asset("assets/logosdab4.png"),
            ),
            //Padding(padding: EdgeInsets.only(top: 20.0)),
            TextWithStyle("SDAB", fontSize: 20.0, color: Colors.white,),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            Container(
              height: 60,
              width: 60,
              child: CircularProgressIndicator(
                //backgroundColor: Colors.white,
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 6,

              ),
            )
          ],
        ),
      ),
    );
  }

}