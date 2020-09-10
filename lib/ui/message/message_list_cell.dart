import 'package:flutter/material.dart';
import 'package:tapiten_app/model/answer.dart';
import 'package:tapiten_app/model/question.dart';
import 'package:tapiten_app/ui/message_detail/message_detail_page.dart';

class MessageListCell extends StatelessWidget {
  final bool isGod;
  final Answer answer;
  final Question question;

  // 神様用のコンストラクタ
  MessageListCell.god({this.answer})
      : isGod = true,
        question = null;

  // 子羊用のコンストラクタ
  MessageListCell.sheep({this.question})
      : isGod = false,
        answer = null;

  @override
  Widget build(BuildContext context) {
    if (isGod)
      return _buildCardForGod(context);
    else
      return _buildCardForSheep(context);
  }

  Widget _buildCardForGod(BuildContext context) {
    return BuildBaseCard(
      title: Text(answer.questionContent),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          // メッセージ詳細画面（神様モード）に遷移する
          return MessageDetailPage.god(
            answer: answer,
          );
        }));
      },
    );
  }

  Widget _buildCardForSheep(BuildContext context) {
    return BuildBaseCard(
      title: Text(
        question.questionContent,
        style: TextStyle(
          color: Color(0xff909090),
          fontFamily: 'RictyDiminished-Regular',
          fontSize: 18,
        ),
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          // メッセージ詳細画面（子羊モード）に遷移する
          return MessageDetailPage.sheep(
            question: question,
          );
        }));
      },
    );
  }
}

class BuildBaseCard extends StatelessWidget {
  BuildBaseCard({
    @required this.title,
    // @required this.subTitle,
    // @required this.icon,
    @required this.onTap,
  });

  final Text title;

  // final Text subTitle;
  // final Icon icon;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: Color(0xFFE9E9E9),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 8,
        ),
        child: ListTile(
          title: title,
          leading: Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("images/sheep.png"),
              ),
            ),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
