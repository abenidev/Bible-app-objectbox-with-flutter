// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:objectbox/objectbox.dart';

@Entity()
class Verse {
  @Id()
  int id;
  int verseId;
  int bookId;
  int chapterNumber;
  int verseNumber;
  String verseText;
  String bibleTranslation;

  Verse({
    this.id = 0,
    required this.verseId,
    required this.bookId,
    required this.chapterNumber,
    required this.verseNumber,
    required this.verseText,
    required this.bibleTranslation,
  });

  Verse copyWith({
    int? id,
    int? verseId,
    int? bookId,
    int? chapterNumber,
    int? verseNumber,
    String? verseText,
    String? bibleTranslation,
  }) {
    return Verse(
      id: id ?? this.id,
      verseId: verseId ?? this.verseId,
      bookId: bookId ?? this.bookId,
      chapterNumber: chapterNumber ?? this.chapterNumber,
      verseNumber: verseNumber ?? this.verseNumber,
      verseText: verseText ?? this.verseText,
      bibleTranslation: bibleTranslation ?? this.bibleTranslation,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'verseId': verseId,
      'bookId': bookId,
      'chapterNumber': chapterNumber,
      'verseNumber': verseNumber,
      'verseText': verseText,
      'bibleTranslation': bibleTranslation,
    };
  }

  factory Verse.fromMap(Map<String, dynamic> map) {
    return Verse(
      id: map['id'] as int,
      verseId: map['verseId'] as int,
      bookId: map['bookId'] as int,
      chapterNumber: map['chapterNumber'] as int,
      verseNumber: map['verseNumber'] as int,
      verseText: map['verseText'] as String,
      bibleTranslation: map['bibleTranslation'] as String,
    );
  }

  factory Verse.fromMapAssetJson(Map<String, dynamic> map, String bibleTranslation) {
    final fieldVals = map['field'] as List<dynamic>;

    return Verse(
      verseId: fieldVals[0],
      bookId: fieldVals[1],
      chapterNumber: fieldVals[2],
      verseNumber: fieldVals[3],
      verseText: fieldVals[4],
      bibleTranslation: bibleTranslation,
    );
  }

  String toJson() => json.encode(toMap());

  factory Verse.fromJson(String source) => Verse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Verse(id: $id, verseId: $verseId, bookId: $bookId, chapterNumber: $chapterNumber, verseNumber: $verseNumber, verseText: $verseText, bibleTranslation: $bibleTranslation)';
  }

  @override
  bool operator ==(covariant Verse other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.verseId == verseId &&
        other.bookId == bookId &&
        other.chapterNumber == chapterNumber &&
        other.verseNumber == verseNumber &&
        other.verseText == verseText &&
        other.bibleTranslation == bibleTranslation;
  }

  @override
  int get hashCode {
    return id.hashCode ^ verseId.hashCode ^ bookId.hashCode ^ chapterNumber.hashCode ^ verseNumber.hashCode ^ verseText.hashCode ^ bibleTranslation.hashCode;
  }
}
