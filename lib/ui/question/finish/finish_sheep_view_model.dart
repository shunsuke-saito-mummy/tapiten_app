import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tapiten_app/firestore/firestoreManager.dart';
import 'package:tapiten_app/model/question.dart';

class Event {}

class FinishSheepViewModel extends ChangeNotifier {
  FinishSheepViewModel(this._question) {
    getResponseFromGod();
  }

  var _returnMainScreenAction = StreamController<Event>();

  StreamController<Event> get returnMainScreenAction => _returnMainScreenAction;

  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  User currentUser;

  Question _question = Question(
    answererId: '',
    answererName: '',
    questionContent: '',
    answer1: '',
    answer2: '',
    godMessage: '',
    selectedAnswerIndex: null,
  );

  Question get question => _question;

  void getCurrentUser() {
    currentUser = FirebaseManager.getCurrentUser();
  }

  Future<void> getResponseFromGod() async {
    getCurrentUser();
    _question = await fetchQuestionDocumentAsync();
    notifyListeners();
  }

  Future<Question> fetchQuestionDocumentAsync() async {
    Question question = Question(
      answererId: '',
      answererName: '',
      questionContent: '',
      answer1: '',
      answer2: '',
      godMessage: '',
      selectedAnswerIndex: null,
    );
    var completer = Completer<Question>();
    Map<String, dynamic> data;

    String questionDocumentIndex;

    await fireStore
        .collection('messages')
        .doc('questions')
        .collection(currentUser.uid)
        .get()
        .then((value) {
      questionDocumentIndex = (value.docs.length - 1).toString();
    });

    await fireStore
        .collection('messages')
        .doc('questions')
        .collection(currentUser.uid)
        .doc(questionDocumentIndex)
        .get()
        .then((value) {
      data = value.data();
      print('fetched data');
      print(data);
    });

    question = Question(
      answererId: data['answerer_id'],
      answererName: data['answerer_name'],
      questionContent: data['question_content'],
      answer1: data['answer1'],
      answer2: data['answer2'],
      godMessage: data['god_message'],
      selectedAnswerIndex: data['selected_answer_index'],
    );

    completer.complete(question);
    return completer.future;
  }

  void returnMainScreen() {
    // opponent_idを初期化して終了
    fireStore
        .collection('matching')
        .doc(currentUser.uid)
        .update({'opponent_id': ''}).then((value) {
      print('success reset opponent id');
    }).catchError((error) {
      print(error);
    });

    _returnMainScreenAction.sink.add(Event());
    notifyListeners();
  }

  @override
  void dispose() {
    _returnMainScreenAction.close();
    super.dispose();
  }
}
