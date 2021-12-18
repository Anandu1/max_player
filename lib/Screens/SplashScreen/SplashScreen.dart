import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:max_player/Screens/FolderView.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? finalPhone;
  String? loginToken;
  bool offerFetched = false;
  bool storeFetched = false;
  bool categoryFetched = false;
  bool userFetched = false;
bool allow=false;
int time=1000;
  @override
  void initState() {
    super.initState();
getPermission();
// getValidationData();

    displaySplash();
  }
  getPermission() async{
    var status = await Permission.storage.status;
    if (status.isGranted) {
      setState(() {
        time=1;
      });
      print(status);
    }
    if (!status.isGranted) {
      await Permission.storage.request(
      );
    }
  }
// Future getValidationData() async{
//     final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//                 var obtainedPhone= sharedPreferences.getString('phone');
//                    var prefToken = sharedPreferences.getString('token');
//                setState(() {
//                   finalPhone=obtainedPhone;
//                   loginToken=prefToken;
//                               });}
  displaySplash() {
    Timer(Duration(seconds: 5), () async {
      Route route = MaterialPageRoute(builder: (_) => HomePage());
      Route homeRoute = MaterialPageRoute(builder: (_) => HomePage());
      SharedPreferences preferences = await SharedPreferences.getInstance();
      if (preferences.getBool('alreadyVisited') == true) {
        Navigator.pushReplacement(context, homeRoute);
      } else
        Navigator.pushReplacement(context, route);
// if(preferences.getBool('alreadyVisited')==true &&
//     offerFetched==true&& storeFetched==true&&
//     categoryFetched==true&& userFetched==true){
//   Navigator.pushReplacement(context, route) ;
// }
//    else
//       Navigator.pushReplacement(context, route) ;
//     });
    });
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width,
        _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFF6CA8F1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              width: _width,
              height: _height,
              decoration: BoxDecoration(
                color:Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: _height / 3.5,
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [Image.asset("assets/Icons/apple_file.png")],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  phoneStatusDialog(BuildContext context, String message, String content) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(message),
            content: Text(content),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Okay",
                      style: TextStyle(color: Colors.green, fontSize: 18),
                    )),
              ),
            ],
          );
        });
  }

  setVisitingFlag() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('alreadyVisited', true);
  }

  getVisitingFlag() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool alreadyVisited = preferences.getBool('alreadyVisited') ?? false;
    return alreadyVisited;
  }

}
