import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth2_4/views/second_screen.dart';
import 'package:firebase_auth2_4/widget/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({Key? key}) : super(key: key);

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

enum SingingCharacter { male, female }

class _AddUserScreenState extends State<AddUserScreen> {
  SingingCharacter? _character = SingingCharacter.male;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _scoreController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
              width: double.infinity,
              child: Center(
                child: Text(
                  'Create Student info',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      fontFamily: 'Yellowtail'),
                ),
              ),
            ),
            TextFieldWidget(
                controller: _nameController, hinttext: 'Enter name'),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: const Text('Male'),
                    leading: Radio<SingingCharacter>(
                      value: SingingCharacter.male,
                      groupValue: _character,
                      onChanged: (SingingCharacter? value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text('Female'),
                    leading: Radio<SingingCharacter>(
                      value: SingingCharacter.female,
                      groupValue: _character,
                      onChanged: (SingingCharacter? value) {
                        setState(() {
                          _character = value;
                          print(value);
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            TextFieldWidget(
                controller: _scoreController, hinttext: 'Enter Score'),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  Map<String, dynamic> map = {
                    'id': Random().nextInt(100000000).toString(),
                    'name': _nameController.text,
                    'gender': 'female',
                    'score': 45.6
                  };
                  var collection =
                      FirebaseFirestore.instance.collection('student');
                  collection
                      .add(map)
                      .then((_) => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SecondScreen(),
                          ),
                          (route) => false))
                      .catchError((error) => print('Add failed: $error'));
                },
                child: const SizedBox(
                  height: 45,
                  width: 200,
                  child: Center(
                      child: Text(
                    'save',
                    style: TextStyle(fontSize: 25),
                  )),
                ))
          ],
        ),
      ),
    );
  }
}
