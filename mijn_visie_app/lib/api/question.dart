import 'package:mijn_visie_app/main.dart';
import 'package:mijn_visie_app/models/questions.dart';

Future<List<Question>?> getQuestions() {
  return dioClient.get(
    "/questions/",
  ).then((value) => (value.data as List?)?.map((e) => Question.fromJson(e)).toList()
  );
}