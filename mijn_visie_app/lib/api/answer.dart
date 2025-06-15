

import 'package:mijn_visie_app/main.dart';
import 'package:mijn_visie_app/models/answer.dart';

Future<Answer?> saveAnswer(String question_id, String answer) {
  return dioClient.post(
    "/answers/",
    data: {
      "question_id": question_id,
      "answer": answer,
    }
  ).then((value) => Answer.fromJson(value.data));
}

Future<List<Answer>?> getAnswers() {
  return dioClient.get(
    "/answers/",
  ).then((value) => (value.data as List?)?.map((e) => Answer.fromJson(e)).toList());
}

Future<Answer?> getAnswer(String id) {
  return dioClient.get(
    "/answers/$id",
  ).then((value) => Answer.fromJson(value.data));
}