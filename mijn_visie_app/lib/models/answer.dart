class Answer {
  late String userId;
  late String questionId;
  late String answer;
  late DateTime created;
  late String id;

  Answer.fromJson(Map<String, dynamic> json) {
    userId = json["user_id"] as String;
    questionId = json["question_id"] as String;
    answer = json["answer"] as String;
    created = DateTime.parse(json["created"] as String);
    id = json["id"] as String;
  }
}
