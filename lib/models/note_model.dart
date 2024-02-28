// To parse this JSON data, do
//
//     final note = noteFromJson(jsonString);

import 'dart:convert';

List<Note> noteFromJson(String str) =>
    List<Note>.from(json.decode(str).map((x) => Note.fromJson(x)));

String noteToJson(List<Note> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Note {
  final String? title;
  final String? description;
  final String? id;

  Note({
    this.title,
    this.description,
    this.id,
  });

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        title: json["title"],
        description: json["description"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "id": id,
      };
}
