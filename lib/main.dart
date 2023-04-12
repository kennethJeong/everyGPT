import 'package:flutter/material.dart';
import 'package:gpts/screens/init.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_config/flutter_config.dart';

final apiKey_chatGPT = Provider((_) => FlutterConfig.get('apiKey_chatGPT'));

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();

  runApp(
    ProviderScope(
      child: GPT(),
    ),
  );
}

class GPT extends HookConsumerWidget {
  GPT({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      home: Scaffold(
        // appBar: AppBar(title: const Text('Example')),
        body: Init(),
      ),
    );
  }
}