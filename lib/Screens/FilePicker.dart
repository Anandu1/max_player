// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:filesystem_picker/filesystem_picker.dart';
// import 'package:path_provider/path_provider.dart';
//
// class FilePicker extends StatefulWidget {
//   const FilePicker({Key? key}) : super(key: key);
//
//   @override
//   _FilePickerState createState() => _FilePickerState();
// }
//
// class _FilePickerState extends State<FilePicker> {
//   Directory? rootPath;
//
//   String? filePath;
//   String? dirPath;
//
//   FileTileSelectMode filePickerSelectMode = FileTileSelectMode.checkButton;
//
//   @override
//   void initState() {
//     _prepareStorage();
//     super.initState();
//   }
//
//   Future<void> _prepareStorage() async {
//     rootPath = await getTemporaryDirectory();
//
//     // Create sample directory if not exists
//     Directory sampleFolder = Directory('${rootPath!.path}/Sample folder');
//     if (!sampleFolder.existsSync()) {
//       sampleFolder.createSync();
//     }
//
//     // Create sample file if not exists
//     File sampleFile = File('${sampleFolder.path}/Sample.txt');
//     if (!sampleFile.existsSync()) {
//       sampleFile.writeAsStringSync('FileSystem Picker sample file.');
//     }
//
//     setState(() {});
//   }
//
//   Future<void> _openFile(BuildContext context) async {
//     String? path = await FilesystemPicker.open(
//       title: 'Open file',
//       context: context,
//       rootDirectory: rootPath!,
//       fsType: FilesystemType.file,
//       folderIconColor: Colors.teal,
//       allowedExtensions: ['.txt'],
//       fileTileSelectMode: filePickerSelectMode,
//       // requestPermission: () async =>
//       // await Permission.storage.request().isGranted,
//     );
//
//     if (path != null) {
//       File file = File('$path');
//       String contents = await file.readAsString();
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(contents),
//         ),
//       );
//     }
//
//     setState(() {
//       filePath = path;
//     });
//   }
//
//   Future<void> _pickDir(BuildContext context) async {
//     String? path = await FilesystemPicker.open(
//       title: 'Save to folder',
//       context: context,
//       rootDirectory: rootPath!,
//       fsType: FilesystemType.folder,
//       pickText: 'Save file to this folder',
//       folderIconColor: Colors.teal,
//       // requestPermission: () async =>
//       // await Permission.storage.request().isGranted,
//     );
//
//     setState(() {
//       dirPath = path;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [Text("HI")],
//         ),
//       ),
//     );
//   }
// }
