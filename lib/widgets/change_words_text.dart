import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:typing/providers/input_provider.dart';

class ChangeWordsText extends ConsumerWidget {
  const ChangeWordsText(this.wordsNumber, {Key? key}) : super(key: key);

  final int wordsNumber;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final input = ref.watch(inputProvider);
    final isSelected = input.numberOfWords == wordsNumber;
    final color = isSelected ? Colors.yellowAccent : const Color(0xff8be9fd);

    return GestureDetector(
      onTap: () {
        ref.read(inputProvider).changeNumberOfWords(wordsNumber);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Text(
          '$wordsNumber',
          style: TextStyle(
            fontSize: 17,
            color: Colors.transparent,
            decoration: isSelected ? TextDecoration.underline : null,
            decorationThickness: 3,
            height: 2,
            shadows: [
              Shadow(
                color: color,
                offset: const Offset(0, -3),
              ),
            ],
            decorationColor: color,
          ),
        ),
      ),
    );
  }
}
