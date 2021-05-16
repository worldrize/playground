import 'dart:collection';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

class CacheableFirebaseStorage {
  /// Storageから取得 or キャッシュを使用
  Future<Uri> getUri(String path) async {
    final url = await FirebaseStorage.instance.ref(path).getDownloadURL();
    // print('storage url: $url');
    final file = await DefaultCacheManager().getSingleFile(url);
    return file.uri;
  }

  /// キャッシュを削除
  Future<void> removeCache() async {
    await DefaultCacheManager().emptyCache();
  }
}

/// 抽象的なプレイヤー
/// - 再生する音声はキューで管理されている
/// - キューが残っている場合は自動ですべて再生される
/// - play(), playAll() は現在のキューを削除し, キューに追加する
abstract class IPlayer {
  /// キューを取得
  Queue<Uri> getQueue();

  /// 音声をキューに追加, すでにキューがある場合削除する
  Future<void> playAll(List<Uri> uris);

  /// 音声を再生, すでにキューがある場合削除する
  Future<void> play(Uri uri);

  /// 音声を一時停止
  void pause();
}

class JustAudioPlayer implements IPlayer {
  AudioPlayer _player = AudioPlayer();
  Queue<Uri> _playQueue = Queue();
  Duration _interval = Duration(milliseconds: 300);

  JustAudioPlayer() {
    _player.playerStateStream.listen((state) async {
      // play next
      if (_playQueue.isNotEmpty &&
          state.processingState == ProcessingState.completed) {
        await Future.delayed(_interval);
        _playQueueFront();
      }
    });
  }

  @override
  Queue<Uri> getQueue() => _playQueue;

  Future<void> _playQueueFront() async {
    // すべて再生済み
    if (_playQueue.isEmpty) {
      return;
    }
    // 再生止める
    _player.stop();

    final uri = _playQueue.removeFirst();
    print('front: $uri, queue: $_playQueue');
    await _player.setAudioSource(AudioSource.uri(uri));
    return _player.play();
  }

  @override
  Future<void> playAll(List<Uri> uris) async {
    _playQueue
      ..clear()
      ..addAll(uris);
    await _playQueueFront();
  }

  @override
  Future<void> play(Uri uri) async {
    _playQueue
      ..clear()
      ..add(uri);
    _playQueueFront();
  }

  @override
  void pause() {
    _player.pause();
  }
}

class AssetsPlayer implements IPlayer {
  AssetsAudioPlayer _player = AssetsAudioPlayer();
  Queue<Uri> _playQueue = Queue();
  Duration _interval = Duration(milliseconds: 300);

  AssetsPlayer() {
    // playAll() 何回か押すと buggy
    _player.playlistAudioFinished.listen((state) async {
      if (_playQueue.isNotEmpty) {
        await Future.delayed(_interval);
        _playQueueFront();
      }
    });
  }

  @override
  Queue<Uri> getQueue() => _playQueue;

  Future<void> _playQueueFront() async {
    // すべて再生済み
    if (_playQueue.isEmpty) {
      return;
    }
    // 再生止める
    _player.stop();

    final uri = _playQueue.removeFirst();
    // print('front: $uri, queue: $_playQueue');
    final audio = Audio.file(uri.path);
    await _player.open(audio);
    return _player.play();
  }

  @override
  Future<void> playAll(List<Uri> uris) async {
    _playQueue
      ..clear()
      ..addAll(uris);
    _playQueueFront();
  }

  @override
  Future<void> play(Uri uri) async {
    _playQueue
      ..clear()
      ..add(uri);
    await _playQueueFront();
  }

  @override
  void pause() {
    _player.pause();
  }
}

/// View Model
class VoiceCachePageNotifier extends ChangeNotifier {
  static VoiceCachePageNotifier _instance;

  factory VoiceCachePageNotifier() {
    return _instance ??= VoiceCachePageNotifier._ctor();
  }

  VoiceCachePageNotifier._ctor() {
    // _player = AssetsPlayer();
    _player = JustAudioPlayer();
  }

  IPlayer _player;

  // IPlayer _player = false ? JustAudioPlayer() : AssetsPlayer();

  CacheableFirebaseStorage storage = new CacheableFirebaseStorage();

  Queue<Uri> getQueue() => _player.getQueue();

  Future<void> playAll() async {
    final uris = [
      await storage.getUri('voices/acting_1_1_en-au.mp3'),
      await storage.getUri('voices/acting_1_1_en-us.mp3'),
      await storage.getUri('voices/acting_1_2_en-uk.mp3'),
    ];

    await _player.playAll(uris);
    print(_player.getQueue());
    notifyListeners();
    print('end playAll()');
  }

  Future<void> play() async {
    final uri = await storage.getUri('voices/acting_1_1_en-au.mp3');
    // print('uri: $uri');
    await _player.play(uri);
    notifyListeners();
    print('end play()');
  }

  void pause() {
    _player.pause();
  }

  void removeCache() {
    storage.removeCache();
  }
}

final _voiceCachePageNotifierProvider =
    ChangeNotifierProvider((ref) => VoiceCachePageNotifier());

class VoiceCachePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final vm = watch(_voiceCachePageNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Voice Cache Sample'),
      ),
      body: Column(
        children: [
          Text('${vm.getQueue()}'),
          RaisedButton(
            onPressed: vm.play,
            child: Text('Play'),
          ),
          RaisedButton(
            onPressed: vm.playAll,
            child: Text('Play All'),
          ),
          RaisedButton(
            onPressed: vm.pause,
            child: Text('Pause'),
          ),
          RaisedButton(
            onPressed: vm.removeCache,
            child: Text('Remove cache'),
          ),
        ],
      ),
    );
  }
}
