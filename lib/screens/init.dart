import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:gpts/screens/answer.dart';
import 'package:gpts/screens/question.dart';

class Init extends HookConsumerWidget {
  const Init({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: Column(
        children: [
          Flexible(
            child: Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: Colors.deepPurple.shade100,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Answer(),
            )
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: Colors.deepPurple.shade100,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Question(),
            ),
          ),
        ],
      )
    );
  }
}