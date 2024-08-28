
import 'dart:convert';

import 'package:bookshelf/domain/entities/villain.dart';

Bookshelf bookshelfFromJson(String str) => Bookshelf.fromJson(json.decode(str));

class Bookshelf {
  List<Book>? data;

  Bookshelf({
    this.data,
  });

  factory Bookshelf.fromJson(Map<String, dynamic> json) => Bookshelf(
        data: json["data"] == null
            ? []
            : List<Book>.from(json["data"]!.map((x) => Book.fromJson(x))),
      );
}

class Book {
  final int? id;
  final String title;
  final String publisher;
  String? handle;
  int? year;
  String? isbn;
  int? pages;
  // List<String>? notes;
  DateTime? createdAt;
  List<Villain>? villains;

  Book(
      {required this.id,
      required this.title,
      required this.publisher,
      this.handle,
      this.year,
      this.isbn,
      this.pages,
      // this.notes,
      this.createdAt,
      this.villains});
        Book copyWith({
    int? id,
    String? title,
    String? publisher,
    String? handle,
    int? year,
    String? isbn,
    int? pages,
    DateTime? createdAt,
    List<Villain>? villains,
  }) {
    return Book(
      id: id ?? this.id,
      title: title ?? this.title,
      publisher: publisher ?? this.publisher,
      handle: handle ?? this.handle,
      year: year ?? this.year,
      isbn: isbn ?? this.isbn,
      pages: pages ?? this.pages,
      createdAt: createdAt ?? this.createdAt,
      villains: villains ?? this.villains,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'Publisher': publisher,
      'handle': handle,
      'Year': year,
      'ISBN': isbn,
      'Pages': pages,
      // 'Notes': notes
    };
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'],
      title: map['Title'],
      publisher: map['Publisher'],
      year: map["Year"],
      handle: map["handle"],
      isbn: map["ISBN"],
      pages: map["Pages"],
      // notes: map["Notes"],
    );
  }

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['Title'],
      publisher: json['Publisher'],
      year: json["Year"],
      handle: json["handle"],
      isbn: json["ISBN"],
      pages: json["Pages"],
      // notes: json["Notes"] == null
      //     ? []
      //     : List<String>.from(json["Notes"]!.map((x) => x)),
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      villains: json["villains"] == null
          ? []
          : List<Villain>.from(
              json["villains"]!.map((x) => Villain.fromJson(x))),

      // description: json['description'],
      // publishedYear: json['publishedYear'],
    );
  }
}


