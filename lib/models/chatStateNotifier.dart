import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Messages {
  late final String question;
  late final String answer;

  Messages({required this.question, required this.answer});

  Map<String, String> toJson() => {"question": question, "answer": answer};
}

////////////////////////////////////////////////////////////////////////////////

class ChatStateNotifier extends StateNotifier<List<Messages>> {
  ChatStateNotifier() : super([]);

  void addMessages(Messages messages) {
    state = [...state, messages];
  }
}
final chatProvider = StateNotifierProvider<ChatStateNotifier, List<Messages>>((ref) {
  return ChatStateNotifier();
});

////////////////////////////////////////////////////////////////////////////////

class ListViewItem extends StateNotifier<List<Widget>> {
  ListViewItem() : super([]);

  void addItem(Widget widget) {
    state = [...state, widget];
  }

  void removeLastOne() {
    state.removeLast();
  }
}
final listViewProvider = StateNotifierProvider<ListViewItem, List<Widget>>((ref) {
  return ListViewItem();
});

////////////////////////////////////////////////////////////////////////////////

