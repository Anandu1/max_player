
import 'package:flutter/cupertino.dart';
import 'package:max_player/Constants/ColorCodes.dart';

class BlackTextButton extends StatelessWidget {
  final String? text;
  const BlackTextButton({Key? key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 225,height: 50,
      decoration: BoxDecoration(
          color: kAppColor,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                offset: Offset(6, 2),
                blurRadius: 6.0,
                spreadRadius: 3.0),
            BoxShadow(
                color: Color.fromRGBO(255, 255, 255, 0.9),
                offset: Offset(-6, -2),
                blurRadius: 6.0,
                spreadRadius: 3.0)
          ]),
      child: Center(child: Text(text!,
        style: TextStyle(fontSize: 25,fontFamily: 'Glacier',color: kDarkGrey),textAlign: TextAlign.center,)),
    );
  }
}
