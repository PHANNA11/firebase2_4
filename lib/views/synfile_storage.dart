import 'dart:async';
import 'dart:io' as io;
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth2_4/controllers/file_storage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SynFileStorage extends StatefulWidget {
  const SynFileStorage({Key? key}) : super(key: key);

  @override
  State<SynFileStorage> createState() => _SynFileStorageState();
}

class _SynFileStorageState extends State<SynFileStorage> {
  PlatformFile? file_picker;
  late Reference ref;
  late File file;
  Future uplaadFile() async {
    final path = "pic/${file}";
    //file = File(file);
    ref = FirebaseStorage.instance.ref().child(path);
    ref.putFile(file);
  }

  selectFile() async {
    final getFile = await FilePicker.platform.pickFiles();
    print(getFile);
    setState(() {
      file_picker = getFile!.files.first;
    });
  }

  selectFileImage() async {
    final getFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    print(getFile!.path);
    setState(() {
      file = io.File(getFile.path);
      // file_picker = getFile.path as PlatformFile?;
    });
  }

  //======= get  ========
  var retrievFile;
  Future<void> _downloadFile(Reference ref) async {
    final io.Directory systemTempDir = io.Directory.systemTemp;
    final io.File tempFile = io.File('${systemTempDir.path}/temp-${ref.name}');
    if (tempFile.existsSync()) await tempFile.delete();

    await ref.writeToFile(tempFile);
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Success!\n Downloaded ${ref.name} \n from bucket: ${ref.bucket}\n '
          'at path: ${ref.fullPath} \n'
          'Wrote "${ref.fullPath}" to tmp-${ref.name}',
        ),
      ),
    );
  }

  //==== get  image =======
  Reference get firestorage => FirebaseStorage.instance.ref();
  Future<String?> getFileStorage(String? imageName) async {
    if (imageName == null) {
      return '';
    }
    try {
      var urlRef = firestorage
          .child(
              '/image/data/user/0/com.example.firebase_auth2_4/cache/file_picker')
          .child('$imageName.png');
      var imageUrl = await urlRef.getDownloadURL();
      setState(() {
        retrievFile = imageUrl;
      });

      print(imageUrl);
      return imageUrl;
    } catch (e) {
      print(e);
      return '';
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Syn Data'),
        actions: [
          IconButton(
              onPressed: () async {
                getFileStorage('LCC-');

                // _downloadFile(ref);
                // getImageFromStorage('Screenshot_1662295352');
                // print(getImageFromStorage('Screenshot_1662295352').toString());
              },
              icon: const Icon(Icons.download))
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              file_picker == null
                  ? const SizedBox()
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
                  //  selectFile();
                  selectFileImage();
                },
                child: const Text('select image'),
              ),
              Container(
                height: 300,
                width: double.infinity,
                child: FutureBuilder(
                  future: FireStoreDatabase().getData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text('something went wrong');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Container(
                          height: 200,
                          width: double.infinity,
                          child: Image.network(snapshot.data.toString()));
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              )
            ],
          ),
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
