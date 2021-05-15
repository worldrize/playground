import 'package:audio_service/audio_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playground/pages/background_audio_task.dart';

class BackgroundAudioPageNotifier extends ChangeNotifier {
  final tracks = [
    MediaItem(
      id: 'assets/sample1.mp3',
      album: 'Lesson 1',
      title: 'Sample 1',
    ),
    MediaItem(
      id: 'assets/sample2.mp3',
      album: 'Lesson 1',
      title: 'Sample 2',
    ),

    // {
    //   'id': 'assets/sample1.mp3',
    //   'album': 'Lesson 1',
    //   'title': 'Sample 1',
    // },
    // {
    //   'id': 'assets/sample2.mp3',
    //   'album': 'Lesson 1',
    //   'title': 'Sample 2',
    // },
  ];

  BackgroundAudioPageNotifier() {
    listen();
  }

  // 現在のトラック
  MediaItem get current => tracks[_index];

  // 再生しているインデックス
  int _index = 0;

  // 再生中か
  bool isPlaying = false;

  void listen() {
    // set tracks
    AudioService.addQueueItems(tracks);

    // state listener
    AudioService.playbackStateStream.listen((state) {
      print(state);
      if (state.processingState == AudioProcessingState.ready) {
        isPlaying == true;
        notifyListeners();
      }
      if (state.processingState == AudioProcessingState.completed) {
        isPlaying = false;
        notifyListeners();
      }
    });

    // item listener
    AudioService.currentMediaItemStream.listen((MediaItem item) {
      print(item.title);
      notifyListeners();
    });
  }

  @override
  void dispose() {
    print('audio service stop');
    AudioService.stop();
    super.dispose();
  }

  // TODO: 自動送り
  void playAll() async {
    // await AudioService.start(
    //   backgroundTaskEntrypoint: backgroundTaskEntryPoint,
    //   // params に MediaItem は渡せない
    //   params: {
    //     'track': track,
    //   },
    // );
    await AudioService.play();
  }

  void pause() async {
    AudioService.pause();
  }

  void next() async {
    _index = (_index + 1) % tracks.length;
    AudioService.addQueueItem(current);
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
            child: vm.isPlaying ? Text('pause') : Text('play'),
            onPressed: () {
              vm.isPlaying ? vm.pause() : vm.playAll();
            },
          ),
          RaisedButton(
            child: Text('next'),
            onPressed: () {
              vm.next();
            },
          ),
          Text(vm.current?.title ?? 'empty'),
          Text(AudioService.queue?.map((track) => track.title)?.join(', ') ??
              'empty queue'),
        ],
      ),
    );
  }
}
