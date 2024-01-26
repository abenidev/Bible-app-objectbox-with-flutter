import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:objectbox_eg/main.dart';
import 'package:objectbox_eg/models/book.dart';
import 'package:objectbox_eg/models/verse.dart';

class BoxLoader {
  BoxLoader._();
  static final booksBox = objectbox.store.box<Book>();
  static final verseBox = objectbox.store.box<Verse>();

  static Future<List<Book>> loadBooks() async {
    if (!booksBox.isEmpty()) {
      List<Book> booksFromBox = booksBox.getAll();
      debugPrint('books already exist in box!');
      return booksFromBox;
    }

    Map<String, dynamic> keyGenreEng = await parseJsonFromAssets('assets/key_genre_english.json');
    Map<String, dynamic> bookKeyEng = await parseJsonFromAssets('assets/key_english.json');

    List<dynamic> bookMapList = bookKeyEng['resultset']['keys'];
    List<dynamic> genreMapList = keyGenreEng['genre'];
    List<Book> booksList = getBooksFromListMap(bookMapList, genreMapList);
    List<int> bookBoxIds = booksBox.putMany(booksList);

    debugPrint('keyEng rows count: ${bookKeyEng['resultset']['keys'].length}');
    debugPrint('keyGenreEng rows count: ${keyGenreEng['genre'].length}');
    debugPrint('booksList: ${booksList[0].toString()}');
    debugPrint('bookBoxIds: ${bookBoxIds}');

    List<Book> booksFromBox = booksBox.getAll();

    return booksFromBox;
  }

  static Future<bool> loadVersesFromAssetJson() async {
    if (!verseBox.isEmpty()) {
      debugPrint('Verses already exist in box!');
      return true;
    }
    verseBox.removeAll();

    Map<String, dynamic> tWeb = await parseJsonFromAssets('assets/t_web.json');

    List<dynamic> versesMapList = tWeb['resultset']['row'];
    List<Verse> versesList = getVersesFromListMap(versesMapList, "WEB");
    List<int> bookVerseIds = verseBox.putMany(versesList);

    debugPrint('versesMapList count: ${versesMapList.length}');
    debugPrint('versesList: ${versesList[0].verseText}');
    debugPrint('bookVerseIds: ${bookVerseIds}');

    return true;
  }

  //
}

//
List<Book> getBooksFromListMap(List<dynamic> bookMapList, List<dynamic> genreMapList) {
  return bookMapList.map((bookMap) => Book.fromMapAssetJson(bookMap, genreMapList)).toList();
}

List<Verse> getVersesFromListMap(List<dynamic> versesMapList, String bookTranslation) {
  return versesMapList.map((verseMap) => Verse.fromMapAssetJson(verseMap, bookTranslation)).toList();
}

Future<Map<String, dynamic>> parseJsonFromAssets(String assetsPath) async {
  debugPrint('--- Parse json from: $assetsPath');
  return rootBundle.loadString(assetsPath).then((jsonStr) => jsonDecode(jsonStr));
}
