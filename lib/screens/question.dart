import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gpts/app_theme.dart';
import 'package:gpts/models/chatStateNotifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

final prompt = StateProvider<String>((ref) => '');

final isInserting = StateProvider<bool>((ref) => false);

final isAsked = StateProvider<bool>((ref) => false);

class Question extends HookConsumerWidget {
  Question({super.key});

  final TextEditingController _textController = TextEditingController();
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Flexible(
          child: TextField(
            textAlign: TextAlign.left,
            textAlignVertical: TextAlignVertical.center,
            textInputAction: TextInputAction.go,
            keyboardType: TextInputType.multiline,
            minLines: 1,
            maxLines: 30,
            controller: _textController,
            onChanged: (text) {
              ref.watch(isInserting.notifier).state = true;
            },
            onTap: () {
              ref.read(isInserting) ? FocusScope.of(context).unfocus() : null;
            },
            decoration: InputDecoration(
              hintText: "Ask anything '◡'",
              floatingLabelBehavior: FloatingLabelBehavior.never,
              contentPadding: const EdgeInsets.all(10),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              suffixIcon: ref.read(isInserting) ? IconButton(
                onPressed: _textController.clear,
                alignment: Alignment.centerRight,
                icon: const Icon(
                  Icons.clear_outlined,
                  color: Colors.black26,
                  size: 20,
                ),
              ) : const SizedBox(
                width: 0,
                height: 0,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 50,
          // 플랫폼 종류에 따라 적당한 버튼 추가
          child: Theme.of(context).platform == TargetPlatform.iOS
            ? CupertinoButton(
                onPressed: ref.watch(isInserting)
                  ? () => _doQuestion(context, ref, _textController.text)
                  : null,
                child: const Text("send"),
            )
            : IconButton(
                onPressed: ref.watch(isInserting)
                  ? () => _doQuestion(context, ref, _textController.text)
                  : null,
                icon: Icon(
                  FontAwesomeIcons.solidPaperPlane,
                  color: MyTheme.kAccentColor,
                  // color: Colors.deepPurple.shade200,
                ),
            ),
        ),
      ],
    );
  }

  void _doQuestion(BuildContext context, WidgetRef ref, String text) {
    _textController.clear();

    FocusScope.of(context).unfocus();

    ref.read(isInserting.notifier).state = false;

    ref.read(isAsked.notifier).state = true;

    ref.read(prompt.notifier).state = text;

    ref.read(listViewProvider.notifier).addItem(
      ChatBubble(
        clipper: ChatBubbleClipper6(type: BubbleType.sendBubble),
        alignment: Alignment.centerRight,
        backGroundColor: MyTheme.kAccentColor,
        margin: const EdgeInsets.only(right: 10, bottom: 10),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * .7,
          ),
          child: Text(
            text.trim(),
            maxLines: null,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.white,
            ),
          )
        ),
      ),
    );

    ref.read(listViewProvider.notifier).addItem(
      Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.only(top: 10, left: 10),
          child: CircularProgressIndicator(
            color: Colors.deepPurple.shade100,
          )
        )
      ),
    );
  }
}

