import 'dart:collection';

import 'package:audioplayers/audioplayers.dart';
import 'package:logger/web.dart';

class AudioSettings {
  static final _logger = Logger();

  final double _defaultBackgroundVolume = 0.60;
  final double _defaultSfxVolume = 0.45;
  final double _defaultGamepadVolume = 0.25;

  final AudioPlayer _background = AudioPlayer();
  final AudioPlayer _sfx = AudioPlayer();
  final AudioPlayer _gamepad = AudioPlayer();

  late Queue _backgroundSongs;

  bool _audioOn = true;

  AudioSettings() {
    _background.setVolume(_defaultBackgroundVolume);
    _sfx.setVolume(_defaultSfxVolume);
    _gamepad.setVolume(_defaultGamepadVolume);
    _backgroundSongs = Queue();
  }

  /// Adds a list of background songs to the queue for playback.
  ///
  /// If the provided list of songs is empty, the method returns immediately
  /// without making any changes. Otherwise, it initializes the background
  /// songs queue and sets up a listener to handle song completion events.
  ///
  /// The songs are expected to be provided as a list of strings, where each
  /// string represents the path or identifier of a song.
  void addBackgroundSongs(List<String> songs) {
    if (songs.isEmpty) {
      return;
    }
    _backgroundSongs.clear();
    _backgroundSongs = Queue.of(songs);
    _background.onPlayerComplete.listen(_handleCompleteSong);
  }

  /// Plays a gamepad sound from the specified source.
  ///
  /// This method attempts to play an audio file for gamepad interactions
  /// using the provided source path. If audio is disabled, the method
  /// returns immediately without playing the sound. Errors during playback
  /// are logged using the internal logger.
  ///
  /// [source] The path or identifier of the audio file to be played.
  Future<void> playGamepad(String source) async {
    try {
      if (!_audioOn) {
        return;
      }
      if (_gamepad.state == PlayerState.playing) {
        await _gamepad.stop();
      }
      await _gamepad.play(AssetSource(source));
    } catch (err) {
      _logger.e(err);
    }
  }

  /// Pauses the background audio playback.
  ///
  /// This method pauses the currently playing background audio track.
  Future<void> pause() async {
    _background.pause();
  }

  /// Plays the first audio track from the background songs queue.
  ///
  /// This method attempts to play the first audio track in the queue of
  /// background songs. If audio is disabled or the queue is empty, the
  /// method returns immediately without playing any audio. Errors during
  /// playback are logged using the internal logger.
  Future<void> playBackgroundAudio() async {
    try {
      if (!_audioOn || _backgroundSongs.isEmpty) {
        _logger.d('No songs to play.');
        return;
      }
      if (_background.state == PlayerState.paused) {
        await _background.resume();
      } else {
        await _background.play(AssetSource(_backgroundSongs.first));
      }
    } catch (err) {
      _logger.e(err);
    }
  }

  /// Handles the completion of a song in the background playlist.
  ///
  /// This method resets the background audio volume to the default level,
  /// moves the completed song to the end of the queue, and introduces a
  /// short delay before playing the next song. It ensures continuous
  /// playback of background music with a brief pause between tracks.
  Future<void> _handleCompleteSong(void_) async {
    _background.setVolume(_defaultBackgroundVolume);
    _backgroundSongs.add(_backgroundSongs.removeFirst());
    //a pause between songs
    await Future.delayed(const Duration(milliseconds: 500), () {
      playBackgroundAudio();
    });
  }

  /// Plays a sound effect from the specified source.
  ///
  /// This method attempts to play a sound effect using the provided source
  /// path. If audio is disabled, the method returns immediately without
  /// playing the sound. Errors during playback are logged using the
  /// internal logger.
  ///
  /// [source] The path or identifier of the audio file to be played.
  Future<void> playSfx(String source) async {
    try {
      if (!_audioOn) {
        return;
      }
      await _sfx.play(AssetSource(source));
    } catch (err) {
      _logger.e(err);
    }
  }

  /// Toggles the audio state between muted and unmuted.
  ///
  /// This method inverts the current audio state. If the background audio
  /// is playing, it adjusts the volume to either the default level or zero,
  /// depending on whether the audio is being unmuted or muted.
  void mute() {
    _audioOn = !_audioOn;
    if (_background.state == PlayerState.playing) {
      _background.setVolume(_audioOn ? _defaultBackgroundVolume : 0);
    }
  }

  /// Preloads a set of audio files into the cache.
  ///
  /// This method logs the start of the preloading process and loads a
  /// predefined list of audio files into the audio cache for quicker
  /// access during playback. The audio files are specified by their
  /// paths within the assets.
  Future<void> preload(String path) async {
    _logger.i('Preloading audio: $path...');
    await AudioCache.instance.load(path);
  }

  /// Sets the background audio volume.
  ///
  /// This method adjusts the volume of the background audio player
  /// to the specified level, where [v] is an integer representing
  /// the volume percentage (0 to 100).
  ///
  /// [v] The desired volume level as a percentage.
  void setBackgroundVolume(int v) {
    _background.setVolume(v / 100);
  }

  /// Sets the sound effects volume.
  ///
  /// This method adjusts the volume of the sound effects player
  /// to the specified level, where [v] is an integer representing
  /// the volume percentage (0 to 100).
  ///
  /// [v] The desired volume level as a percentage.
  void setSfxVolume(int v) {
    _sfx.setVolume(v / 100);
  }

  /// Stops the background audio playback.
  ///
  /// This method halts any currently playing background audio track.
  Future<void> stop() async {
    await _background.stop();
  }

  /// Resumes the background audio playback.
  ///
  /// This method resumes the playback of the background audio track
  /// if it was previously paused.
  Future<void> resume() async {
    await _background.resume();
  }
}
