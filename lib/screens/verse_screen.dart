import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:objectbox_eg/helpers/query_helper.dart';
import 'package:objectbox_eg/models/book.dart';
import 'package:objectbox_eg/models/verse.dart';

class VerseScreen extends ConsumerStatefulWidget {
  const VerseScreen({super.key, required this.book, required this.chapter});
  final Book book;
  final int chapter;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VerseScreenState();
}

enum TTsAudioState {
  stopped,
  playing,
}

class _VerseScreenState extends ConsumerState<VerseScreen> {
  List<Verse> verses = [];
  FlutterTts flutterTts = FlutterTts();
  TTsAudioState tTsAudioState = TTsAudioState.stopped;

  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() {
    List<Verse> versesFromBox = BoxQueryHelper.getVerseFromBookId(widget.book, widget.chapter);
    setState(() => verses.addAll(versesFromBox));
    debugPrint('versesFromBox: ${versesFromBox.length}');
  }

  Future speak(List<Verse> verses) async {
    await flutterTts.awaitSpeakCompletion(true);

    for (int i = 0; i < verses.length; i++) {
      var result = await flutterTts.speak(verses[i].verseText);
      debugPrint('speak result: ${result}');
      if (result == 1) setState(() => tTsAudioState = TTsAudioState.playing);
    }
  }

  Future stop() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => tTsAudioState = TTsAudioState.stopped);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.book.name} ${widget.chapter}'),
        actions: [
          IconButton(
            onPressed: () async {
              if (tTsAudioState == TTsAudioState.stopped) {
                await speak(verses);
                return;
              } else {
                await stop();
                return;
              }
            },
            icon: tTsAudioState == TTsAudioState.stopped ? const Icon(Icons.play_arrow) : const Icon(Icons.stop),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
          itemCount: verses.length,
          itemBuilder: (context, index) => Text(
            '${verses[index].verseNumber} ${verses[index].verseText}',
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
