import 'package:astrologer_app/models/all_astrologer.dart';
import 'package:flutter/material.dart';

class UtilFunctions {
  static Future<DateTime?> showDatePikcer(BuildContext context) async {
    return await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(3000),
    );
  }

  static String formatUnderscoreString(String str) {
    var l = str.split('_');
    return l.map((e) => e.capitalize()).join(' ');
  }

  static String formatEndTime(Map<String, dynamic> endTime) {
    var hr = endTime["hour"];
    var min = endTime["minute"];
    var sec = endTime["second"];
    var str = '';
    if (hr != null && hr != 0) {
      str += hr.toString() + ' hr';
    }
    if (min != null && min != 0) {
      str += ' ' + min.toString() + ' min';
    }
    if (sec != null && sec != 0) {
      str += ' ' + sec.toString() + ' sec';
    }

    return str;
  }

  static String getAstrologerName(Astrologer astrologer) {
    return (astrologer.namePrefix != null ? "${astrologer.namePrefix} " : "") +
        "${astrologer.firstName} ${astrologer.lastName ?? ''}";
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
