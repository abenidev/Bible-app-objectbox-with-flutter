import 'package:objectbox_eg/helpers/loader_helper.dart';
import 'package:objectbox_eg/models/book.dart';
import 'package:objectbox_eg/models/verse.dart';
import 'package:objectbox_eg/objectbox.g.dart';

class BoxQueryHelper {
  BoxQueryHelper._();

  static List<Verse> getVerseFromBookId(Book book, int chapterNumber) {
    final verseBox = BoxLoader.verseBox;

    Query<Verse> query = verseBox.query(Verse_.bookId.equals(book.bookId).and(Verse_.chapterNumber.equals(chapterNumber))).build();
    final results = query.find();
    query.close();
    return results;
  }

  //
}
