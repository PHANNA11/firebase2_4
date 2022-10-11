import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

Student studentFromJson(String str) => Student.fromJson(json.decode(str));

String studentToJson(Student data) => json.encode(data.toJson());

class Student {
  Student({
    required this.id,
    required this.name,
    required this.gender,
    required this.score,
    required this.image,
  });

  String id;
  String name;
  String gender;
  String score;
  String image;

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        id: json["id"].toString(),
        name: json["name"],
        gender: json["gender"],
        score: json["score"].toString(),
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "gender": gender,
        "score": score,
        "image": image,
      };
  void displayData() {
    print('Id=$id');
    print('Name:$name');
  }
}
