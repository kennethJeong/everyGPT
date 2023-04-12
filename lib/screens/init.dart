import 'package:flutter/material.dart';
import 'package:gpts/main.dart';
import 'package:gpts/utils/httpParse.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Init extends HookConsumerWidget {
  final String prompt;
  const Init(this.prompt, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final apiKey = ref.watch(apiKey_chatGPT);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Result from GPT"),
      ),
      body: FutureBuilder<String>(
        future: generateText(apiKey, prompt),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Text('${snapshot.data}');
          }
        },
      ),
    );
  }
}