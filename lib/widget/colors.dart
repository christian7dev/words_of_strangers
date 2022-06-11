import 'package:flutter/material.dart';


extension ColorConverter on String{
  toColor(){
    var hexColor = this.replaceAll("#", "");
    if (hexColor.length == 6){
      hexColor = "FF" + hexColor;
      Color col = Color(int.parse("0x$hexColor"));
      return Color.fromRGBO(col.red, col.green, col.blue, 1);
    }
    else if (hexColor.length == 8){

      Color col = Color(int.parse("0x${hexColor.replaceRange(6, 8, "")}"));

      return Color.fromRGBO(col.red, col.green, col.blue, 1);

    }
  }
}


















