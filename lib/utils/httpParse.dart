import 'dart:convert';
import 'package:gpts/models/chatStateNotifier.dart';
import 'package:http/http.dart' as http;
import 'package:gpts/main.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<String> completionText(WidgetRef ref, String prompt) async {
  final apiKey = ref.read(apiKey_chatGPT);
  const apiUrl = 'https://api.openai.com/v1/completions';

  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey'
    },
    body: jsonEncode({
      'model': 'text-davinci-003',
      'prompt': prompt,
      'max_tokens': 1000,
      'temperature': 0,
      'top_p': 1,
      'frequency_penalty': 0,
      'presence_penalty': 0
    }),
  );

  Map<String, dynamic> res = jsonDecode(utf8.decode(response.bodyBytes));

  return res['choices'][0]['text'];
}

Future<String> completionChat(WidgetRef ref, String prompt) async {
  final messageRecords = ref.read(chatProvider);

  final apiKey = ref.read(apiKey_chatGPT);
  const apiUrl = 'https://api.openai.com/v1/chat/completions';

  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    },
    body: jsonEncode({
      'model': 'gpt-3.5-turbo',
      'messages' : [
        {
          "role": "system",
          "content": "You know well about South Korea. Don't answer questions that are not related to Korea, but answer them like a young and kind woman in South Korea.",
        },
        {
          "role": "assistant",
          "content": messageRecords.isNotEmpty ? messageRecords.last.answer : '',
        },
        {
          "role": "user",
          "content": prompt,
        },
      ],
      'max_tokens': 1000,
      // 'max_tokens': 256,
      'temperature': 0,
      'top_p': 1,
      'frequency_penalty': 0,
      'presence_penalty': 0
    }),
  );

  Map<String, dynamic> res = jsonDecode(utf8.decode(response.bodyBytes));

  return res['choices'][0]['message']['content'];
}



