import 'dart:convert';
import 'dart:ffi';

import 'package:firebase_auth2_4/models/lecture_model.dart';

Student studentFromJson(String str) => Student.fromJson(json.decode(str));

String studentToJson(Student data) => json.encode(data.toJson());

class Student {
  Student({
    required this.id,
    required this.name,
    required this.gender,
    required this.score,
    required this.image,
    required this.nickname,
    required this.lecture,
  });
  String id;
  String name;
  String gender;
  String score;
  String image;
  List<String> nickname;
  late Lecture lecture;
  factory Student.fromJson(Map<String, dynamic> json) => Student(
      id: json["id"].toString(),
      name: json["name"],
      gender: json["gender"],
      score: json["score"].toString(),
      image: json["image"],
      nickname: json["nicknames"],
      lecture: json["lecture"]);
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "gender": gender,
        "score": score,
        "image": image,
        "nicknames": nickname,
        "lecture": lecture.toJson(),
      };
  void displayData() {
    print('Id=$id');
    print('Name:$name');
    print('LectureName:${lecture.lectureName}');

    for (var temp in nickname) {
      print(temp);
    }
  }
}
