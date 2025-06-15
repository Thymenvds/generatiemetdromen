
import 'package:get/get.dart';
import 'package:mijn_visie_app/models/answer.dart';
import 'package:mijn_visie_app/models/questions.dart';
import 'package:mijn_visie_app/api/question.dart' as api;
import 'package:mijn_visie_app/api/answer.dart' as api_answer;

import '../api/answer.dart' as api;

class MyQuestionsController extends GetxController {
  static MyQuestionsController get to => Get.find<MyQuestionsController>();

  List<Question> questions = [];
  List<Answer> answers = [];

  Answer? getLatestAnswer(Question question) {
    List<Answer> answers_on_question = answers.where((answer) => answer.questionId == question.id).toList();
    if (answers_on_question.isEmpty) {return null;}
    answers_on_question.sort((a, b) => b.created.compareTo(a.created));
    return answers_on_question.first;
  }

  void getQuestions() async {
    List<Question>? re = await api.getQuestions();
    if (re != null) {
      questions = re;
    } else {
      Get.snackbar('Could not fetch questions', '');
    }
    List<Answer>? re_answer = await api_answer.getAnswers();
    if (re_answer != null) {
      answers = re_answer;
    } else {
      Get.snackbar('Could not fetch questions', '');
    }
    update();
  }

  Future<bool> saveAnswer(String questionId, String answer) async {
    Answer? re = await api.saveAnswer(questionId, answer);
    if (re != null) {
      Get.snackbar('Answer saved', '');
      answers.add(re);
      update();
      return true;
    }
    return false;
  }
}