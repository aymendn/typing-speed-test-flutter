import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:typing/providers/input_provider.dart';
import 'package:typing/widgets/input.dart';

final indexProvider = Provider<int>((ref) {
  throw UnimplementedError();
});

final isHoverProvider = StateProvider<bool>((ref) {
  return false;
});

final isFocusedProvider = StateProvider<bool>((ref) {
  return false;
});

class TypeCard extends ConsumerWidget {
  const TypeCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final input = ref.watch(inputProvider);
    final isHover = ref.watch(isHoverProvider);
    final isFocused = ref.watch(isFocusedProvider);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xff44475a),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Wrap(
            spacing: 15,
            runSpacing: 7,
            children: [
              for (int i = 0; i < input.numberOfWords; i++)
                ProviderScope(
                  overrides: [indexProvider.overrideWithValue(i)],
                  child: const WordText(),
                ),
            ],
          ),
          const SizedBox(height: 25),
          SizedBox(
            height: 60,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Input(),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: ref.read(inputProvider).reset,
                  onFocusChange: (value) =>
                      ref.read(isFocusedProvider.notifier).state = value,
                  onHover: (value) =>
                      ref.read(isHoverProvider.notifier).state = value,
                  style: ElevatedButton.styleFrom(
                    side: getBorderSide(isFocused, isHover),
                  ),
                  child: Text(
                    'redo',
                    style: TextStyle(
                      fontSize: 20,
                      color: isHover
                          ? const Color(0xFF78FFED)
                          : const Color(0xffff79c6),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Color? getWordColor(bool? status, bool isCurrentWord) {
  if (isCurrentWord) return const Color(0xFFFFFF51);

  switch (status) {
    case true:
      return const Color(0xFF50FFAA);
    case false:
      return const Color(0xFFFF5E5C);
    default:
      return null;
  }
}

class WordText extends ConsumerWidget {
  const WordText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(indexProvider);
    final input = ref.watch(inputProvider);
    return Text(
      input.words[index],
      style: TextStyle(
        color: getWordColor(
            input.wordsStatus[index], input.currentWordIndex == index),
        fontSize: 17,
      ),
    );
  }
}

BorderSide? getBorderSide(bool isFocus, bool isHover) {
  if (isHover) return const BorderSide(width: 3, color: Color(0xFF78FFED));
  if (isFocus) return const BorderSide(width: 2, color: Color(0xffff79c6));
  return null;
}
