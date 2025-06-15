
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mijn_visie_app/controllers/my_questions_controller.dart';
import 'package:mijn_visie_app/models/answer.dart';

enum QuestionType {mc, open}
/// Corresponds to the User relation in the Database
class Question {
  late QuestionType type;
  late String title;
  late String? description;
  late List<String>? options;
  late String? previousVersion;
  late DateTime created;
  late String id;

  // User(
  //     {required this.firstname,
  //     required this.lastname,
  //     required this.email,
  //     required this.username,
  //     required this.pk});

  /// Constructor for a User instance from [json] (JSON format)
  Question.fromJson(Map<String, dynamic> json) {
    type = QuestionType.values.byName(json["type"]);
    title = json["title"] as String;
    description = json["description"] as String?;
    options = (json['options'] as List?)?.map((e) => e as String).toList();
    previousVersion = json["previous_version"] as String?;
    created = DateTime.parse(json['created'] as String);
    id = json["id"] as String;
  }

  Widget getQuestionWidget(Answer? answered) {
    return QuestionWidget(question: this, answered: answered);
  }
}

class QuestionWidget extends StatefulWidget {
  final Answer? answered;
  final Question question;
  const QuestionWidget({super.key, required this.question, this.answered});

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  final ExpansibleController tile_controller = ExpansibleController();
  final radioKey = GlobalKey<_RadioQuestionState>();

  @override
  void dispose() {
    tile_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AnswerWidget answer_widget = (widget.question.type == QuestionType.mc && widget.question.options != null)
    ? RadioQuestion(key:radioKey, options: widget.question.options!, answer: widget.answered?.answer)
    : OpenQuestion(answer: widget.answered?.answer);
    return  ExpansionTile(
      title: Text(widget.question.title),
      subtitle: widget.question.description == null ? null : Text(widget.question.description!),
      trailing: widget.answered != null ? const Icon(Icons.check_circle_outlined, color: Color(0xFF00FF00)) : null,
      controlAffinity: ListTileControlAffinity.leading,
      controller: tile_controller,
      children: <Widget>[
        Column(
          children: [
            answer_widget,
            ElevatedButton(
              child: Text("Save"),
              onPressed: () {
                String? answer = answer_widget.getAnswer();
                if (answer == null) {
                  Get.snackbar("Please answer before saving.", "");
                } else {
                  MyQuestionsController.to.saveAnswer(widget.question.id, answer).then((v) {if(v) {tile_controller.collapse();}});
                }
              },
            )
          ],  
        )
      ],
    );
  }
}

abstract interface class AnswerWidget extends StatefulWidget {
  String? getAnswer();
}

class RadioQuestion extends StatefulWidget implements AnswerWidget{
  final List<String> options;
  final GlobalKey<_RadioQuestionState> key;
  final String? answer;
  const RadioQuestion({required this.key, required this.options, this.answer});

  @override
  State<RadioQuestion> createState() => _RadioQuestionState();

  @override
  String? getAnswer() {
    return key.currentState?.getAnswer();
  }
}

class _RadioQuestionState extends State<RadioQuestion> {
  String? _answer;

  @override
  void initState() {
    super.initState();
    _answer = widget.answer;
  }
  @override
  Widget build(BuildContext context) {
    return RadioGroup<String>(
      groupValue: _answer,
      onChanged: (String? value) {
        setState(() {
          _answer = value;
        });
      },
      child: Column(
        children: widget.options.map((option) => ListTile(leading: Radio<String>(value:option), title: Text(option),)).toList()
      ),
    );
  }

  String? getAnswer() => _answer;
}

class OpenQuestion extends StatefulWidget implements AnswerWidget{
  late TextEditingController controller;
  OpenQuestion({super.key, String? answer}) {
    controller = TextEditingController(text: answer);
  }

  @override
  State<OpenQuestion> createState() => _OpenQuestionState();

  @override
  String? getAnswer() {
    return controller.text == "" ? null : controller.text;
  }
}

class _OpenQuestionState extends State<OpenQuestion> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: (email) {
        if (email!.isEmpty) {
          return 'Please enter something';
        }
        return null;
      },
    );
  }
}