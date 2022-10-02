import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class SynFileStorage extends StatefulWidget {
  const SynFileStorage({Key? key}) : super(key: key);

  @override
  State<SynFileStorage> createState() => _SynFileStorageState();
}

class _SynFileStorageState extends State<SynFileStorage> {
  PlatformFile? file_picker;

  Future uplaadFile() async {
    final path = "image/${file_picker!.path}";
    final file = File(file_picker!.path!);
    final ref = FirebaseStorage.instance.ref().child(path);
    ref.putFile(file);
  }

  selectFile() async {
    final getFile = await FilePicker.platform.pickFiles();
    setState(() {
      file_picker = getFile!.files.first;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Syn Data'),
      ),
      body: Center(
        child: Column(
          children: [
            file_picker == null
                ? SizedBox()
                : Container(
                    height: 300,
                    width: 300,
                    child: Image.file(File(file_picker!.path.toString())),
                  ),
            file_picker == null
                ? const Text('No... file')
                : Text(file_picker!.path.toString()),
            ElevatedButton(
              onPressed: () async {
                selectFile();
              },
              child: const Text('select image'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          uplaadFile();
        },
        child: const Icon(Icons.upload),
      ),
    );
  }
}
