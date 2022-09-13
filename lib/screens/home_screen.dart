import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:typing/providers/input_provider.dart';
import 'package:typing/widgets/change_words_text.dart';

import '../style.dart';
import '../widgets/type_card.dart';

final actionButtonsColor = WindowButtonColors(
  iconNormal: Colors.white,
);

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final input = ref.watch(inputProvider);
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              ColoredBox(
                color: const Color(0xFF2D3244),
                child: WindowTitleBarBox(
                  child: Row(
                    children: [
                      Expanded(child: MoveWindow()),
                      Row(
                        children: [
                          MinimizeWindowButton(colors: actionButtonsColor),
                          MaximizeWindowButton(colors: actionButtonsColor),
                          CloseWindowButton(colors: actionButtonsColor),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    children: [
                      const Text(
                        'Typing',
                        style: h1,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 25),
                      width > 350
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _wordNumbers(),
                                _wpeAndAcc(input),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _wordNumbers(),
                                _wpeAndAcc(input),
                              ],
                            ),
                      const SizedBox(height: 15),
                      const TypeCard(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Text _wpeAndAcc(InputNotifier input) {
    return Text(
      'WPM: ${input.wpm} / ACC: ${input.accuracy}%',
      style: const TextStyle(fontSize: 16),
      textAlign: TextAlign.end,
    );
  }

  Row _wordNumbers() {
    return Row(
      children: [
        for (final wordsNumber in [10, 25, 50, 100]) ...[
          ChangeWordsText(wordsNumber),
          if (wordsNumber != 100)
            const Text('/', style: TextStyle(fontSize: 18)),
        ],
      ],
    );
  }
}
