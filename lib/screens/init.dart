import 'package:flutter/material.dart';
import 'package:gpts/main.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';

class Init extends HookConsumerWidget {
  const Init({super.key});

  @override
  Widget build(context, ref) {

    final abc = ref.watch(apiKey_chatGPT);
    print(abc);


    return Container(

    );
  }
}