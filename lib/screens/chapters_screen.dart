import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:objectbox_eg/models/book.dart';
import 'package:objectbox_eg/screens/verse_screen.dart';

class ChaptersScreen extends ConsumerWidget {
  const ChaptersScreen({super.key, required this.book});
  final Book book;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('${book.name} Chapters')),
      body: SizedBox(
        child: ListView.builder(
          itemCount: book.chaptersLength,
          itemBuilder: (context, index) => ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => VerseScreen(book: book, chapter: index + 1)),
              );
            },
            title: Text('${index + 1}'),
          ),
        ),
      ),
    );
  }
}
