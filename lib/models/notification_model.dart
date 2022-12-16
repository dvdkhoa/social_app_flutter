class NotificationModel {
  String? id;
  String? message;
  String? thumbnail;
  String? intent;
  String? created;
  bool? seen;

  NotificationModel(
      {this.id,
        this.message,
        this.thumbnail,
        this.intent,
        this.created,
        this.seen});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    thumbnail = json['thumbnail'];
    intent = json['intent'];
    created = json['created'];
    seen = json['seen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['message'] = this.message;
    data['thumbnail'] = this.thumbnail;
    data['intent'] = this.intent;
    data['created'] = this.created;
    data['seen'] = this.seen;
    return data;
  }
}