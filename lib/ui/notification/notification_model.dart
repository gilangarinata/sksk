class NotificationModel {
  final int id;
  final String title;
  final String description;
  final String url;
  final String image;

  NotificationModel(
      this.id, this.title, this.description, this.url, this.image);

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'title': title,
        'description': description,
        'url' : url,
        'image' : image
      };

  factory NotificationModel.fromJson(dynamic json) {
    return NotificationModel(
        1,
        json['title'] as String,
        json['description'] as String,
      json['url'] as String,
      json['image'] as String,
    );
  }
}