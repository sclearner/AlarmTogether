import 'package:alarmtogether/views/templates/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Time12hInputFormatter extends TextInputFormatter {
  (String, String) time(String value) {
    var split = value.split(":");
    if (split.length == 1) return (value, "");
    else return (split.first, split.last);
  }

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    int newLength = newValue.text.length;
    if (newLength == 6 || newLength < oldValue.text.length) return oldValue;
    if (newValue.text.length == 1) {
      if (int.parse(newValue.text) > 1) {
        return TextEditingValue(
          text: "0${newValue.text}:",
        );
      }
      else return newValue;
    }
    if (newValue.text.length == 2) {
      if (int.parse(newValue.text) > 11) {
        return TextEditingValue(text: "0${newValue.text[0]}:");
      }
      return TextEditingValue(text: "${newValue.text}:");
    }
    (String, String) timer = time(newValue.text);
    if (timer.$2.length == 1) {
      if (int.parse(timer.$2) > 5) return TextEditingValue(text: "${timer.$1}:0${timer.$2}");
    }
    return newValue;
  }

}

class Time24hInputFormatter extends TextInputFormatter {
  (String, String) time(String value) {
    var split = value.split(":");
    if (split.length == 1) return (value, "");
    else return (split.first, split.last);
  }

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    int newLength = newValue.text.length;
    if (newLength == 6) return oldValue;
    if (newLength > oldValue.text.length) {
      if (newValue.text.length == 1) {
        if (int.parse(newValue.text) > 2) {
          return TextEditingValue(
            text: "0${newValue.text}:",
          );
        }
        else return newValue;
      }
      if (newValue.text.length == 2) {
        if (newLength < oldValue.text.length) return newValue;
        if (int.parse(newValue.text) > 23) {
          if (int.parse(newValue.text[1]) > 5) return TextEditingValue(text: "0${newValue.text[0]}:0${newValue.text[1]}");
          return TextEditingValue(text: "0${newValue.text[0]}:${newValue.text[1]}");
        }
        return TextEditingValue(text: "${newValue.text}:");
      }
      (String, String) timer = time(newValue.text);
      if (timer.$2.length == 1) {
        if (int.parse(timer.$2) > 5) return TextEditingValue(text: "${timer.$1}:0${timer.$2}");
      }
      return newValue;
    }
    else if (newLength < oldValue.text.length) {
      if (newLength == 3) return TextEditingValue(
        text: newValue.text.substring(0,2)
      );
      else return newValue;
    }
    else return oldValue;
  }

}