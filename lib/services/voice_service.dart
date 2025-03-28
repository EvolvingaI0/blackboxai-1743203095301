import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class VoiceService {
  final FlutterTts _tts = FlutterTts();
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;

  Future<void> initialize() async {
    await _tts.setLanguage('pt-BR');
    await _tts.setSpeechRate(0.5);
    await _tts.setVolume(1.0);
    await _tts.setPitch(1.0);
  }

  Future<bool> startListening(Function(String) onResult) async {
    bool available = await _speech.initialize();
    if (available) {
      _speech.listen(
        onResult: (result) {
          if (result.finalResult) {
            onResult(result.recognizedWords);
          }
        },
      );
      _isListening = true;
      return true;
    }
    return false;
  }

  Future<void> stopListening() async {
    await _speech.stop();
    _isListening = false;
  }

  Future<void> speak(String text) async {
    await _tts.speak(text);
  }

  bool get isListening => _isListening;
}