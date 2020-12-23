import 'package:flutter/material.dart';

class TextWithStyle extends Text{
  TextWithStyle(String data, {textAlign: TextAlign.justify, color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.normal}) :
        super(
          data,
          textAlign: textAlign,
          style: new TextStyle(
              color: color,
              fontSize: fontSize,
              fontWeight: fontWeight
          ));
}