class ApiModel {
  final int userId;
  final String id;
  final String title;
  final String body;

  ApiModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory ApiModel.fromJson(Map<String, dynamic> json) {
    return ApiModel(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}
