import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:objectbox_eg/helpers/loader_helper.dart';
import 'package:objectbox_eg/models/book.dart';
import 'package:objectbox_eg/screens/chapters_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool isLoading = true;
  List<Book> books = [];

  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() async {
    List<Book> booksLoaded = await BoxLoader.loadBooks();
    bool isVerseLoadedFromJson = await BoxLoader.loadVersesFromAssetJson();
    if (isVerseLoadedFromJson) {
      setState(() => books.addAll(booksLoaded));
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Books')),
      body: Container(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: books.length,
                itemBuilder: (context, index) => ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChaptersScreen(book: books[index])),
                    );
                  },
                  title: Text(books[index].name),
                  subtitle: Text('Genre: ${books[index].genre} \nChapters: ${books[index].chaptersLength}'),
                  isThreeLine: true,
                ),
              ),
      ),
    );
  }
}
