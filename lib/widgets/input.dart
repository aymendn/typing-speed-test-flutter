import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:typing/providers/input_provider.dart';

class Input extends ConsumerWidget {
  const Input({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final input = ref.watch(inputProvider);
    focusNode.requestFocus();
    return Expanded(
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        onChanged: (val) => ref.read(inputProvider.notifier).update(val),
        onSubmitted: (_) => focusNode.requestFocus(),
        style: const TextStyle(fontSize: 22),
        decoration: InputDecoration(
          hintText: input.endTime == null ? input.currentWord : null,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          focusedBorder: borderStyle(Colors.white54),
          enabledBorder: borderStyle(Colors.transparent),
          errorBorder: borderStyle(Colors.red.shade300.withOpacity(.5)),
          focusedErrorBorder: borderStyle(Colors.red),
          errorStyle: const TextStyle(height: 0,),
          errorText: input.error,
          fillColor: input.error == null
              ? const Color(0xff282a36)
              : const Color(0x3CFF4646),
          filled: true,
        ),
      ),
    );
  }
}

OutlineInputBorder borderStyle(Color color) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(
        width: 2,
        color: color,
      ),
    );
