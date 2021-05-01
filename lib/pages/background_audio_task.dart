import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

// Audio Service
void backgroundTaskEntryPoint() async {
  AudioServiceBackground.run(() => SampleAudioTask());
}

// バックグラウンドのタスク UIとは分離されている
class SampleAudioTask extends BackgroundAudioTask {
  // 任意のAudioPlayerを使用可能
  final _player = AudioPlayer();

  // TODO: Start時に全ての MediaItem を設定して切り替えできるようにすべき
  // params: Map<String, List<{id, album, title}>>
  @override
  Future<void> onStart(Map<String, dynamic> params) async {
    print('onStart()');

    final o = params['track'];
    final track = MediaItem(id: o['id'], album: o['album'], title: o['title']);
    print(o);

    // Backgroundにメディアを設定
    AudioServiceBackground.setMediaItem(track);

    _player.playerStateStream.listen((state) {
      print('state: $state');

      final processingState = {
        ProcessingState.idle: AudioProcessingState.none,
        ProcessingState.loading: AudioProcessingState.connecting,
        ProcessingState.buffering: AudioProcessingState.buffering,
        ProcessingState.ready: AudioProcessingState.ready,
        ProcessingState.completed: AudioProcessingState.completed,
      }[state.processingState];

      AudioServiceBackground.setState(
          playing: state.playing,
          processingState: processingState,
          controls: [
            MediaControl.skipToPrevious,
            state.playing ? MediaControl.pause : MediaControl.play,
            MediaControl.skipToNext,
          ]);
    });

    await _player.setAsset(track.id);
  }

  @override
  Future<void> onPlay() => _player.play();

  @override
  Future<void> onPause() => _player.pause();

  @override
  Future<void> onSkipToNext() async {
    print('onSkipToNext');
  }

  @override
  Future<void> onSkipToPrevious() async {
    print('onSkipToPrevious');
  }
}
