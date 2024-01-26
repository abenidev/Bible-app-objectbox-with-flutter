// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:objectbox/objectbox.dart';

@Entity()
class Book {
  @Id()
  int id;
  int bookId;
  String name;
  int chaptersLength;
  String testment;
  String genre;

  Book({
    this.id = 0,
    required this.bookId,
    required this.name,
    required this.chaptersLength,
    required this.testment,
    required this.genre,
  });

  Book copyWith({
    int? id,
    int? bookId,
    String? name,
    int? chaptersLength,
    String? testment,
    String? genre,
  }) {
    return Book(
      id: id ?? this.id,
      bookId: bookId ?? this.bookId,
      name: name ?? this.name,
      chaptersLength: chaptersLength ?? this.chaptersLength,
      testment: testment ?? this.testment,
      genre: genre ?? this.genre,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'bookId': bookId,
      'name': name,
      'chaptersLength': chaptersLength,
      'testment': testment,
      'genre': genre,
    };
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'] as int,
      bookId: map['bookId'] as int,
      name: map['name'] as String,
      chaptersLength: map['chaptersLength'] as int,
      testment: map['testment'] as String,
      genre: map['genre'] as String,
    );
  }

  factory Book.fromMapAssetJson(Map<String, dynamic> map, List<dynamic> genreMapList) {
    return Book(
      bookId: map['b'] as int,
      name: map['n'] as String,
      chaptersLength: map['c'] as int,
      testment: map['t'] as String,
      genre: genreMapList.firstWhere((genreMap) => genreMap['g'] as int == map['g'] as int)['n'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Book.fromJson(String source) => Book.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Book(id: $id, bookId: $bookId, name: $name, chaptersLength: $chaptersLength, testment: $testment, genre: $genre)';
  }

  @override
  bool operator ==(covariant Book other) {
    if (identical(this, other)) return true;

    return other.id == id && other.bookId == bookId && other.name == name && other.chaptersLength == chaptersLength && other.testment == testment && other.genre == genre;
  }

  @override
  int get hashCode {
    return id.hashCode ^ bookId.hashCode ^ name.hashCode ^ chaptersLength.hashCode ^ testment.hashCode ^ genre.hashCode;
  }
}
