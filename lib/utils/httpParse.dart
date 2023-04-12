import 'dart:convert';
import 'package:http/http.dart' as http;

const apiUrl = 'https://api.openai.com/v1/completions';

Future<String> generateText(String apiKey, String prompt) async {
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey'
    },
    body: jsonEncode({
      "model": "text-davinci-003",
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
