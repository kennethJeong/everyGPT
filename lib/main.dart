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
      child: MaterialApp(
        home: GPT(),
      ),
    ),
  );
}

class GPT extends HookConsumerWidget {
  GPT({super.key});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('ChatGPT')),
      // body: Init(),
      body: Column(
        children: [
          TextField(
            controller: _controller,
          ),
          TextButton(
            onPressed: () {
              String prompt = _controller.text;
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => Init(prompt))
              );
            },
            child: const Text("Get Result"),
          )
        ],
      ),
    );
  }
}