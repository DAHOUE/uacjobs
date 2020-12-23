import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Chargement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Center(
      /*child: new TextAvecStyle('Chargement en cours ...',
        fontSize: 30.0,
        fontStyle: FontStyle.italic,),*/
        child: Container(
          height: 50,
          width: 50,
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation(Colors.green),
            strokeWidth: 6,

            //semanticsValue: '20%',
          ),
        ));
  }
}