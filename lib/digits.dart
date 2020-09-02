import 'package:flutter/material.dart';

class digits extends StatelessWidget {
  final color;
  final digitcolor;
  final String buttontext;
  final onclick;

  digits({this.color,this.digitcolor,this.buttontext,this.onclick});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onclick,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: color,
            child: Center(
              child: Text(buttontext,style: TextStyle(color: digitcolor,
                  fontSize: 22),),
            ),
          ),
        ),
      ),
    );
  }
}
