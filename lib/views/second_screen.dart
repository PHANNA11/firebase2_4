import 'package:firebase_auth2_4/models/student_model.dart';
import 'package:firebase_auth2_4/views/add_user_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  List<String> docsId = [];
  Future<Student?> getStudent(String docId) async {
    final docStudent =
        FirebaseFirestore.instance.collection('student').doc(docId);
    final snapshot = await docStudent.get();
    if (snapshot.exists) {
      return Student.fromJson(snapshot.data()!);
    }
    return Student.fromJson(snapshot.data()!);
  }

  Future getDocsID() async {
    await FirebaseFirestore.instance.collection('student').get().then((value) {
      value.docs.forEach((DocumentSnapshot document) {
        setState(() {
          docsId.add(document.reference.id);
          // print('DataID:${document.reference.id}');
        });
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
      body: ListView.builder(
          itemCount: docsId.length,
          itemBuilder: (context, index) {
            return FutureBuilder<Student?>(
              future: getStudent(docsId[index]),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Something wrong....!!'),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: Text('Laoding.....'),
                  );
                } else {
                  final datas = snapshot.data;
                  return datas == null
                      ? const Center(
                          child: Text('No student'),
                        )
                      : buildViewStudent(datas);
                }
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddUserScreen(),
              ));
        },
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }

  Widget buildViewStudent(Student student) {
    return Card(
      child: ListTile(
          leading: SizedBox(
              height: 60, width: 60, child: Image.network(student.image)),
          title: Text(student.name)),
    );
  }
}
