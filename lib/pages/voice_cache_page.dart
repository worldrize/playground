import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

class CacheableFirebaseStorage {
  /// Storageから取得 or キャッシュを使用
  Future<Uri> getUri(String path) async {
    final url = await FirebaseStorage.instance.ref(path).getDownloadURL();
    print('storage url: $url');
    final file = await DefaultCacheManager().getSingleFile(url);
    return file.uri;
  }

  /// キャッシュを削除
  Future<void> removeCache() async {
    await DefaultCacheManager().emptyCache();
  }
}

/// 抽象的なプレイヤー
abstract class IPlayer {
  play(Uri uri);

  stop();
}

class JustAudioPlayer implements IPlayer {
  AudioPlayer _player = AudioPlayer();

  @override
  play(Uri uri) {
    _player.setAudioSource(AudioSource.uri(uri));
    _player.play();
  }

  @override
  stop() {
    _player.stop();
  }
}

class AssetsAudioPlayer implements IPlayer {
  AssetsAudioPlayer _player = AssetsAudioPlayer();

  @override
  play(Uri uri) {
    _player.play(uri);
  }

  @override
  stop() {
    _player.stop();
  }
}

class VoiceCachePageNotifier extends ChangeNotifier {
  CacheableFirebaseStorage storage = new CacheableFirebaseStorage();

  // IPlayer _player = AssetsAudioPlayer();
  IPlayer _player = JustAudioPlayer();

  void play() async {
    final uri = await storage.getUri('voices/acting_1_1_en-au.mp3');
    print('uri: $uri');
    _player.play(uri);
  }

  void stop() {
    _player.stop();
  }

  void removeCache() {
    service.removeCache();
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
          RaisedButton(
            onPressed: vm.play,
            child: Text('Play'),
          ),
          RaisedButton(
            onPressed: vm.stop,
            child: Text('Stop'),
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
