import 'dart:io';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:file_manager/file_manager.dart';
import 'package:flutter/material.dart';
import 'package:max_player/Constants/ColorCodes.dart';
import 'package:max_player/Screens/FolderItems.dart';
import 'package:max_player/Widgets/BlackTextButton.dart';
import 'package:max_player/Widgets/ClayTextField.dart';
import 'package:max_player/services/video_player.dart';
import 'package:permission_handler/permission_handler.dart';

import 'ThumbNails.dart';
class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FileManagerController controller = FileManagerController();
String view = "grid";
  var perm=Permission.storage.status;
  bool? permission;
  bool dark=false;
  TextEditingController textEditingController =TextEditingController();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  getPermission() async{
    var status = await Permission.storage.status;
    if (status.isGranted) {
      setState(() {
        permission=true;
      });
      print(status);
    }
    if (!status.isGranted) {
      await Permission.storage.request(
      );
    }
  }
  Future<void> requestPermission(Permission permission) async {
    final status = await permission.request();

    setState(() {
      print(status);
      perm = status as Future<PermissionStatus>;
      print(perm);
    });
  }
  @override
  Widget build(BuildContext context) {
    // Creates a widget that registers a callback to veto attempts by the user to dismiss the enclosing
    // or controllers the system's back button

    return WillPopScope(
      onWillPop: () async {
        if (await controller.isRootDirectory()) {
          return true;
        } else {
          controller.goToParentDirectory();
          return false;
        }
      },
      child: FutureBuilder(
future: getPermission(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
  return

    Scaffold(
      backgroundColor:
      dark==true ? Colors.black:
      kAppColor,
      appBar: AppBar(
        backgroundColor:
        dark==true ? Colors.black:
        kAppColor,
        actions: [
          // IconButton(
          //   onPressed: () => createFolder(context),
          //   icon: Icon(Icons.create_new_folder_outlined,color:
          //   dark==true ? kAppColor:
          //   Colors.grey[800]),
          // ),
          IconButton(
            onPressed: () => sort(context),
            icon: Icon(Icons.sort_by_alpha_outlined,color:   dark==true ? kAppColor:
            Colors.grey[800]),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                view=="grid" ?
                view="list":
                view=="list" ?
                view="grid":view="grid";
              });
            },
            icon:
            view=="grid" ? Icon(Icons.apps,color: Colors.lightBlue):
            Icon(Icons.apps,color:    dark==true ? kAppColor:
            Colors.grey[800]),
          ),
          // IconButton(
          //   onPressed: () => OtpDialog(context, "Network Stream", false),
          //   icon: Icon(Icons.sd_storage_rounded,color:   dark==true ? kAppColor:
          //   Colors.grey[800]),
          // ) ,
          IconButton(
            onPressed: () => setState(() {
              dark=!dark;
            }),
            icon: Icon(Icons.nightlight_outlined,color:   dark==true ? kAppColor:
            Colors.grey[800],),
          )
        ],
        title:Text("Max Player",style: TextStyle(color:    dark==true ? kAppColor:
        Colors.grey[800]),),
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back,color: Colors.grey[800]),
        //   onPressed: () async {
        //     await controller.goToParentDirectory();
        //   },
        // ),
      ),
      body:
      Container(
        margin: EdgeInsets.all(10),
        child: FileManager(
          controller: controller,
          builder: (context, snapshot) {
            final List<FileSystemEntity> entities = snapshot;
            return
              entities==null ? Container():
              (entities!=null&& view=="grid") ?
              GridView.builder(
                itemCount: entities.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.5,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0),
                itemBuilder: (context, index) {
                  FileSystemEntity entity = entities[index];
                  return
                    GestureDetector(
                        onTap: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context){
                                return FolderItems(path:entity.path ,);
                              }));
                        },
                        child: folderTile(FileManager.basename(entity,true),FileManager.isFile(entity))!);
                },

              ):
              ListView.builder(
                shrinkWrap: true,
                itemCount: entities.length,
                itemBuilder: (context, index) {
                  FileSystemEntity entity = entities[index];
                  return
                    GestureDetector(
                        onTap: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context){
                                return FolderItems(path:entity.path ,);
                              }));
                        },
                        child: folderTile(FileManager.basename(entity,true),FileManager.isFile(entity))!);
                  //   Card(
                  //   child: ListTile(
                  //     leading: FileManager.isFile(entity)
                  //         ? Icon(Icons.feed_outlined)
                  //         : Icon(Icons.folder),
                  //     title: Text(FileManager.basename(entity,true)),
                  //     subtitle: subtitle(entity),
                  //     onTap: () async {
                  //       if (FileManager.isDirectory(entity)) {
                  //         entity.exists()==true ?
                  //             controller.openDirectory(entity):
                  //         // open the folder
                  //         Navigator.push(context,
                  //             MaterialPageRoute(builder: (context){
                  //               return FolderItems(path:entity.path ,);
                  //             }));
                  //
                  //         // delete a folder
                  //         // await entity.delete(recursive: true);
                  //
                  //         // rename a folder
                  //         // await entity.rename("newPath");
                  //
                  //         // Check weather folder exists
                  //         // entity.exists();
                  //
                  //         // get date of file
                  //         // DateTime date = (await entity.stat()).modified;
                  //       } else {
                  //         // Navigator.push(context,
                  //         //     MaterialPageRoute(builder: (context){
                  //         //       return LocalVideoDisplay(file:entity);
                  //         //     }));
                  //         // delete a file
                  //         // await entity.delete();
                  //
                  //         // rename a file
                  //         // await entity.rename("newPath");
                  //
                  //         // Check weather file exists
                  //         // entity.exists();
                  //
                  //         // get date of file
                  //         // DateTime date = (await entity.stat()).modified;
                  //
                  //         // get the size of the file
                  //         // int size = (await entity.stat()).size;
                  //       }
                  //     },
                  //   ),
                  // );
                },
              );
          },
        ),
      ));
        },

      ),
    );
  }

  Widget subtitle(FileSystemEntity entity) {
    return FutureBuilder<FileStat>(
      future: entity.stat(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (entity is File) {
            int size = snapshot.data!.size;

            return Text(
              "${FileManager.formatBytes(size)}",
            );
          }
          return Text(
            "${snapshot.data!.modified}",
          );
        } else {
          return Text("");
        }
      },
    );
  }

  selectStorage(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: FutureBuilder<List<Directory>>(
          future: FileManager.getStorageList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final List<FileSystemEntity> storageList = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: storageList
                        .map((e) => ListTile(
                      title: Text(
                        "${FileManager.basename(e)}",
                      ),
                      onTap: () {
                        controller.openDirectory(e);
                        Navigator.pop(context);
                      },
                    ))
                        .toList()),
              );
            }
            return Dialog(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  sort(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                  title: Text("Name"),
                  onTap: () {
                    controller.sortedBy = SortBy.name;
                    Navigator.pop(context);
                  }),
              ListTile(
                  title: Text("Size"),
                  onTap: () {
                    controller.sortedBy = SortBy.size;
                    Navigator.pop(context);
                  }),
              ListTile(
                  title: Text("Date"),
                  onTap: () {
                    controller.sortedBy = SortBy.date;
                    Navigator.pop(context);
                  }),
              ListTile(
                  title: Text("type"),
                  onTap: () {
                    controller.sortedBy = SortBy.type;
                    Navigator.pop(context);
                  }),
            ],
          ),
        ),
      ),
    );
  }

  createFolder(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController folderName = TextEditingController();
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: TextField(
                    controller: folderName,
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      // Create Folder
                      await FileManager.createFolder(
                          controller.getCurrentPath, folderName.text);
                      // Open Created Folder
                      controller.setCurrentPath =
                          controller.getCurrentPath + "/" + folderName.text;
                    } catch (e) {}

                    Navigator.pop(context);
                  },
                  child: Text('Create Folder'),
                )
              ],
            ),
          ),
        );
      },
    );
  }
  Widget? folderTile(String folderName,bool isFile){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 75,
        decoration: BoxDecoration(
            color:
            dark==true ? Colors.black:
            kAppColor,
            borderRadius: BorderRadius.circular(7.0),
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
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            isFile ==true ? Expanded(
                flex: 8,
                child: Icon(Icons.feed_outlined)):
            Expanded(
                flex: 8,
                child: Image.asset("assets/Icons/apple_file.png")),
            Expanded(
                flex: 4,
                child: Text(folderName,
                style: TextStyle(
                  color:    dark==true ? kAppColor:
                  Colors.black,
                ),))
          ],
        ),
      ),
    );
  }
  OtpDialog(BuildContext context, String message, bool? emboss) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: kAppColor,
            title: Center(
                child: Text(
                  message,
                  style: TextStyle(
                      color: kLogoTextColor,
                      fontSize: 20,
                      fontFamily: 'Glacier',
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                )),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClayTextField(height: 50,hint: "Enter Url",
                  textEditingController: textEditingController,),
                SizedBox(height: 30,),
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: BlackTextButton(
                            text: "Cancel",
                          )),
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    Expanded(
                      flex: 5,
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(context, MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return VideoDisplay(videoUrl: textEditingController.text,);
                                }));
                          },
                          child: BlackTextButton(
                            text: "Go",
                          )),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }
}