import 'package:firebase_auth2_4/get_student_widget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  List<String> docsId = [];
  Future getDocsID() async {
    await FirebaseFirestore.instance.collection('student').get().then((value) {
      value.docs.forEach((DocumentSnapshot document) {
        docsId.add(document.reference.id);
        print('DataID:${document.reference.id}');
      });
    });
  }

  var temDocsId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    temDocsId = getDocsID();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second screen'),
      ),
      body: FutureBuilder(
        future: temDocsId,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Something wrong....!!'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Text('Laoding.....'),
            );
          }
          return ListView.builder(
            itemCount: docsId.length,
            itemBuilder: (context, index) {
              return GetStudentData(docsID: docsId[index]);
            },
          );
        },
      ),
    );
  }
}
