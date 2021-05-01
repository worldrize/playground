import 'package:audio_service/audio_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playground/pages/background_audio_task.dart';

class BackgroundAudioPageNotifier extends ChangeNotifier {
  var i = 0;

  final tracks = [
    {
      'id': 'assets/sample1.mp3',
      'album': 'Lesson 1',
      'title': 'Sample 1',
    },
    {
      'id': 'assets/sample2.mp3',
      'album': 'Lesson 1',
      'title': 'Sample 2',
    },
  ];

  @override
  void dispose() {
    print('audio service stop');
    AudioService.stop();
    super.dispose();
  }

  void play() async {
    final track = tracks[i];

    print('play $i ${track["title"]}');
    await AudioService.start(
      backgroundTaskEntrypoint: backgroundTaskEntryPoint,
      // params に MediaItem は渡せない
      params: {
        'track': track,
      },
    );
    await AudioService.play();

    i = (i + 1) % tracks.length;
    notifyListeners();
  }
}

final _notifierProvider =
    ChangeNotifierProvider((_) => BackgroundAudioPageNotifier());

class BackgroundAudioPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final vm = watch(_notifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Background Audio'),
      ),
      body: Column(
        children: [
          RaisedButton(
            child: Text('Play'),
            onPressed: () {
              vm.play();
            },
          ),
        ],
      ),
    );
  }
}
