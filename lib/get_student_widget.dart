import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class GetStudentData extends StatelessWidget {
  GetStudentData({required this.docsID, Key? key}) : super(key: key);
  String docsID;
  @override
  Widget build(BuildContext context) {
    CollectionReference stu = FirebaseFirestore.instance.collection('student');
    return FutureBuilder<DocumentSnapshot>(
      future: stu.doc(docsID).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Card(
            child: ListTile(
                leading: CircleAvatar(
                  child: Text(data['id'].toString()),
                ),
                title: Text(data['name'].toString())),
          );
        }
        return const Center(
          child: Text('Loading....!!!'),
        );
      },
    );
  }
}
