import 'dart:core';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:gpts/models/chatStateNotifier.dart';
import 'package:gpts/screens/question.dart';
import 'package:gpts/utils/httpParse.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

class Answer extends HookConsumerWidget {
  Answer({super.key});

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final question = ref.watch(prompt).trim();
    final _isAsked = ref.watch(isAsked);

    WidgetsBinding.instance.addPostFrameCallback((_) => {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          curve: Curves.easeOutExpo,
          duration: const Duration(milliseconds: 500),
        )
      }
    });

    if(_isAsked) {
      completionChat(ref, question).then((value) {
        ref.read(listViewProvider.notifier).removeLastOne();

        final answer = value.trim();

        ref.read(listViewProvider.notifier).addItem(
          ChatBubble(
            clipper: ChatBubbleClipper6(type: BubbleType.receiverBubble),
            alignment: Alignment.centerLeft,
            backGroundColor: const Color(0xffE7E7ED),
            margin: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * .7
              ),
              child: Text(
                answer.trim(),
                maxLines: null,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                ),
              )
            ),
          ),
        );

        ref.read(isAsked.notifier).state = false;

        final messageSet = Messages(question: question, answer: answer);
        ref.read(chatProvider.notifier).addMessages(messageSet);

        // final abc = ref.read(chatProvider);
        // for(var i=0; i<abc.length; i++) {
        //   print(abc[i]);
        // }

        // print(ref.read(chatProvider));
        // print(messageSet.toJson());
      });
    }

    return ListView.builder(
      reverse: true,
      controller: _scrollController,
      scrollDirection: Axis.vertical,
      itemCount: ref.read(listViewProvider).length,
      itemBuilder: (context, index) {

        return Column(
          children: [
            ref.watch(listViewProvider)[index]
          ],
        );
      },
    );
  }
}






// 학습형 대화 - 이전 대화와 연관지어서 다음 메세지를 알려줄 수 있게 설계하기 ! <완료>