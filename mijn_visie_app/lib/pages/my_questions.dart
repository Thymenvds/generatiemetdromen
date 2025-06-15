import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mijn_visie_app/controllers/my_questions_controller.dart';

class MyQuestionsPage extends StatelessWidget {
  final Widget drawer;

  const MyQuestionsPage(this.drawer, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer,
      appBar: AppBar(
          title: const Text("Mijn Visie"),
          // actions: <Widget>[],
        ),
      body: GetBuilder<MyQuestionsController>(
        builder:(controller) {
          return ListView(
            children: controller.questions.map((question) => question.getQuestionWidget(controller.getLatestAnswer(question))).toList(),
          );
        },
      )
    );
  }
}