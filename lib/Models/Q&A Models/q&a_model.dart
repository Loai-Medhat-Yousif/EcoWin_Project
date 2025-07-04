class QuestionAndAnswerModel {
  final String question;
  final String answer;
  bool isExpanded = false;

  QuestionAndAnswerModel({
    required this.question,
    required this.answer,
  });

  factory QuestionAndAnswerModel.fromJson(Map<String, dynamic> json) {
    return QuestionAndAnswerModel(
      question: json['question'],
      answer: json['answer'],
    );
  }
}
