import 'package:flutter/material.dart';
import 'package:tapiten_app/firestore/firestoreManager.dart';
import 'package:tapiten_app/ui/message/model/answer.dart';
import 'package:tapiten_app/ui/message/model/question.dart';

class MessageList extends ChangeNotifier {
  List<Answer> answers;
  List<Question> questions;
  FirestoreManager _firestoreManager = FirestoreManager();

  // 神様用のメッセージ一覧画面コンストラクタ
  MessageList.god({this.answers}) {
    fetchMessageList(true);
  }

  // 子羊のメッセージ一覧画面用コンストラクタ
  MessageList.sheep({this.questions}) {
    fetchMessageList(false);
  }

  void fetchMessageList(bool isGod) async {
    if (isGod) {
      answers = await _firestoreManager.fetchAnswerMessagesCollectionAsync();
    } else {
      questions = await _firestoreManager.fetchQuestionMessagesCollectionAsync();
    }
    notifyListeners();
  }
}
