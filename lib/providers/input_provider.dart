import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:typing/words.dart';

final controller = TextEditingController();
final focusNode = FocusNode();

final inputProvider = ChangeNotifierProvider<InputNotifier>((ref) {
  return InputNotifier();
});

class InputNotifier extends ChangeNotifier {
  int currentWordIndex = 0;
  int rightWords = 0;
  int numberOfWords = 25;
  String text = '';
  int wpm = 0;

  DateTime? startTime;
  DateTime? endTime;

  DateTime get currentTime => DateTime.now();

  final List<String> _words = Words.top100Words..shuffle();

  List<String> get words {
    switch (numberOfWords) {
      case 50:
        return _words.sublist(0, 50);
      case 25:
        return _words.sublist(0, 25);
      case 10:
        return _words.sublist(0, 10);
      default:
        return _words;
    }
  }

  int get numberOfWrittenCaracters {
    return words.sublist(0, currentWordIndex).fold(controller.text.length,
        (previousValue, word) => previousValue + word.length);
  }

  int get totalNumberOfRightCaracters {
    int sum = 0;
    for (var i = 0; i < numberOfWords; i++) {
      if (wordsStatus[i] == true) sum += words[i].length;
    }
    return sum;
  }

  int get getWpm {
    if (timeInMinutes == 0) {
      return 0;
    }

    return ((totalNumberOfRightCaracters / 5) / timeInMinutes).round();
  }

  double get timeInMinutes {
    if (startTime == null ||
        currentTime.difference(startTime!).inSeconds == 0) {
      return 0.1;
    }

    if (endTime == null) {
      return currentTime.difference(startTime!).inMilliseconds / 60000;
    }

    return endTime!.difference(startTime!).inMilliseconds / 60000;
  }

  void changeNumberOfWords(int newNum) {
    numberOfWords = newNum;
    reset();
  }

  String get currentWord => Words.top100Words[currentWordIndex];

  List<bool?> wordsStatus = List.generate(100, (index) => null);

  int get accuracy {
    if (currentWordIndex == 0) return 0;
    return (rightWords / currentWordIndex * 100).round();
  }

  String? get error {
    final currWord = Words.top100Words[currentWordIndex];
    final typedText = controller.text;

    final isMatching = currWord.length >= typedText.length &&
        currWord.substring(0, typedText.length) == controller.text;

    if (isMatching || typedText.isEmpty) {
      return null;
    }

    return '';
  }

  void reset() {
    currentWordIndex = 0;
    rightWords = 0;
    wordsStatus = List.generate(100, (index) => null);
    controller.clear();
    _words.shuffle();
    startTime = null;
    endTime = null;
    text = '';

    notifyListeners();
  }

  void update(String val) {
    if (val.isEmpty) {
      text = '';
      notifyListeners();
      return;
    }

    if (val[val.length - 1] == ' ') {
      controller.clear();
    }

    if (endTime != null) return;

    if (currentWordIndex == 0 && val.length == 1) {
      startTime = currentTime;
    }

    if (val[val.length - 1] == ' ' && val != ' ') {
      final isCorrectWord = val.substring(0, val.length - 1) ==
          Words.top100Words[currentWordIndex];

      wordsStatus[currentWordIndex] = isCorrectWord;

      if (isCorrectWord) rightWords++;

      if (currentWordIndex == numberOfWords - 1) {
        endTime = currentTime;
      }

      wpm = getWpm;

      currentWordIndex++;
    }

    text = controller.text;
    notifyListeners();
  }
}
