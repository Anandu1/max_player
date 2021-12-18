import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:max_player/Constants/ColorCodes.dart';
class ClayTextField extends StatelessWidget {
  final String? hint;
  final double? width;
  final double? height;
  final TextEditingController? textEditingController;
  const ClayTextField({Key? key, this.hint, this.width, this.height, this.textEditingController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return
      ClayContainer(
        emboss: true,
        borderRadius: 50,
        color: kAppColor,
        width: width,
        height: height,
        child: TextField(
          controller: textEditingController,
          expands: true,
          minLines: null,
          maxLines: null,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintStyle: TextStyle(fontFamily: 'Glacier',letterSpacing: 1.5),
              hintText: hint),
        ),
      );
    ;
  }
}
