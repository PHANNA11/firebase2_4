import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class TextFieldWidget extends StatelessWidget {
  TextFieldWidget({required this.controller, required this.hinttext, Key? key})
      : super(key: key);
  TextEditingController controller;

  String hinttext;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration:
            InputDecoration(hintText: hinttext, border: OutlineInputBorder()),
      ),
    );
  }
}
