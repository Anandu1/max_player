import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_manager/flutter_file_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:max_player/Constants/ColorCodes.dart';
import 'package:max_player/services/video_player.dart';
import 'package:path_provider_ex/path_provider_ex.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class FolderItems extends StatefulWidget{
  final String? path;
  const FolderItems({Key? key, this.path}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _FolderItems();
  }
}

class _FolderItems extends State<FolderItems>{
  var files;
  File? videoFile;
  List? thumbNails=[];
  List? localThumbNails=[];
  FileManagerSorting sorting=FileManagerSorting.Date;
  void getFiles(FileManagerSorting _sorting) async { //asyn function to get list of files
    List<StorageInfo> storageInfo = await PathProviderEx.getStorageInfo();
    var root = storageInfo[0].rootDir; //
    // storageInfo[1] for SD card, geting the root directory
    var fm = FileManager(root: Directory(widget.path!)); //
    files = await fm.filesTree(
        sortedBy: _sorting,
        //set fm.dirsTree() for directory/folder tree list
        excludedPaths: ["/storage/emulated/0/Android"],
        extensions: ["mp4", "mkv"] //optional, to filter files, remove to list all,
      //remove this if your are grabbing folder list
    );
    createThumb( files);
    setState(() {}); //update the UI
  }
  saveThumb(var thumbNails) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setStringList("thumbNails", thumbNails);
  }
  getThumb() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      localThumbNails=  preferences.getStringList("thumbNails");
    });
  }

  createThumb(List fileThumb)async{
    for(int i=0;i<=fileThumb.length-1;i++){
      final uint8list = await VideoThumbnail.thumbnailData(
        video: fileThumb[i].path,
        imageFormat: ImageFormat.JPEG,
        maxHeight: 100,
        maxWidth: 128, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
        quality: 100,
      );
      setState(() {
        thumbNails!.add(uint8list);
      });
      // saveThumb(thumbNails);
    }
  }
  @override
  void initState() {
    getFiles(FileManagerSorting.Date); //call getFiles() function on initial state.
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kAppColor,
        appBar: AppBar(
          title:Text("Max Player",style: TextStyle(color: Colors.grey[800]),),
          backgroundColor: Colors.white,
          centerTitle: true,
          actions: [
            // RaisedButton(
            //   color:Colors.redAccent ,
            //     child: Text("sort"),
            //     onPressed: (){
            //     setState(() {
            //       getFiles(FileManagerSorting.Size);
            //     });
            //     })
          ],
        ),
        body:
        files == null?
        CircularProgressIndicator():
        // files.length==thumbNails!.length ?
        GridView.builder(  //if file/folder list is grabbed, then show here
          itemCount: files?.length ?? 0,
          itemBuilder: (context, index) {
            // createThumb(files[index],files);
            return
              GestureDetector(
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context){
                          return LocalVideoDisplay(file:
                          files[index],place_Holder:files[index].path.split('/').last.toString() ,);
                        }));
                  },
                  child:
                  index>=thumbNails!.length ? loadingTile(files[index].path.split('/').last.toString(), index):
                  videoTile(thumbNails![index], files[index].path.split('/').last.toString(),index)
                //     Card(
                //       child:ListTile(
                //         title: Text(files[index].path.split('/').last.toString(),
                //           overflow: TextOverflow.ellipsis,maxLines: 1,),
                //         subtitle:thumbNails![index]==null ? Icon(Icons.image):
                //         Image.memory(thumbNails![index])
                //        ,
                //       )
                // ),
              );
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.5,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0),
        )
      // :CircularProgressIndicator()
    );
  }
  pickVideo(File video_File) async {
    final video =
    await ImagePicker.platform.pickVideo(source: ImageSource.gallery);
    setState(() {
      videoFile = File(video!.path);
    });
    Navigator.push(context,
        MaterialPageRoute(builder: (context){
          return LocalVideoDisplay(file:
          videoFile);
        }));
    // videoPlayerController = VideoPlayerController.file(videoFile!)
    //   ..initialize().then((_) {
    //     setState(() {
    //       videoPlayerController!.play();
    //     });
    //   });
  }
  _getImage(File videofile) async {
    final uint8list = await VideoThumbnail.thumbnailData(
      video: videofile.path,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 128, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
      quality: 25,
    );
    return uint8list;
  }
  Widget? videoTile(Uint8List image,String name,int index){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
            color: kAppColor,
            borderRadius: BorderRadius.circular(7.0),
            boxShadow: [
              BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.1),
                  offset: Offset(6, 2),
                  blurRadius: 1.0,
                  spreadRadius: 3.0),
              BoxShadow(
                  color: Color.fromRGBO(255, 255, 255, 0.9),
                  offset: Offset(-6, -2),
                  blurRadius: 1.0,
                  spreadRadius: 3.0)
            ]),
        child: Column(
          children: [
            Expanded(
                child:
                index>thumbNails!.length
                    ?CircularProgressIndicator():
                Image.memory(image)),
            Expanded(child: Text(name,textAlign: TextAlign.center,maxLines: 3,))
          ],
        ),
      ),
    );
  }
  Widget? loadingTile(String name,int index){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
            color: kAppColor,
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
        child: Column(
          children: [
            // Text(index.toString()),
            // Text(thumbNails!.length.toString()),
            Container(),
            Expanded(child: Text(name,textAlign: TextAlign.center,))
          ],
        ),
      ),
    );
  }
}


