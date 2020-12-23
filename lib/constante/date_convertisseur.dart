import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class DateConvertisseur {
  String convertirDate(String string) {
    String il = 'il y a';
    String format = 'yyyy-MM-dd HH:mm:ss.Z';
    var formatter = DateFormat(format);
    DateTime dateTime = formatter.parse(string);
    if (dateTime == null) {
      return "Date incoonue";
    } else {
      var difference = new DateTime.now().difference(dateTime);
      var jours = difference.inDays;
      var heures = difference.inHours;
      var minutes = difference.inMinutes;
      int mois = (jours / 30).toInt();


      if (mois > 1) {
        return "$il $mois mois";
      } else if (mois == 1) {
        return "$il 1 mois";
      } else if (jours > 1) {
        return "$il $jours jours";
      } else if (jours == 1) {
        return "$il 1 jour";
      } else if (heures > 1) {
        return "$il $heures heures";
      } else if (heures == 1) {
        return "$il 1 heure";
      } else if (minutes > 1) {
        return "$il $minutes minutes";
      } else if (minutes == 1) {
        return "$il 1 minute";
      } else {
        return "A l'instant";
      }
    }
  }

  String convertirDateDans(String string) {
    String il = 'Dans ';
    String format = 'yyyy-MM-dd HH:mm:ss.Z';
    var formatter = DateFormat(format);
    DateTime dateTime = formatter.parse(string);
    if (dateTime == null) {
      return "Date incoonue";
    } else {
      var difference = new DateTime.now().difference(dateTime);
      var jours = difference.inDays;
      var heures = difference.inHours;
      var minutes = difference.inMinutes;
      int mois = (jours / 30).toInt();


      if (mois > 1) {
        return "$il $mois mois";
      } else if (mois == 1) {
        return "$il 1 mois";
      } else if (jours > 1) {
        return "$il $jours jours";
      } else if (jours == 1) {
        return "$il 1 jour";
      } else if (heures > 1) {
        return "$il $heures heures";
      } else if (heures == 1) {
        return "$il 1 heure";
      } else if (minutes > 1) {
        return "$il $minutes minutes";
      } else if (minutes == 1) {
        return "$il 1 minute";
      } else {
        return "A l'instant";
      }
    }
  }
}