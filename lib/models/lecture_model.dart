import 'package:meta/meta.dart';
import 'dart:convert';

Lecture lectureFromJson(String str) => Lecture.fromJson(json.decode(str));

String lectureToJson(Lecture data) => json.encode(data.toJson());

class Lecture {
  Lecture({
    required this.lectureId,
    required this.lectureName,
    required this.subject,
  });

  String lectureId;
  String lectureName;
  String subject;

  factory Lecture.fromJson(Map<String, dynamic> json) => Lecture(
        lectureId: json["lectureID"],
        lectureName: json["lectureName"],
        subject: json["subject"],
      );

  Map<String, dynamic> toJson() => {
        "lectureID": lectureId,
        "lectureName": lectureName,
        "subject": subject,
      };
}
