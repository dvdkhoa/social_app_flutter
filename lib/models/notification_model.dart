

class NotificationModel {
  String? id;
  String? message;
  String? thumbnail;
  String? type;
  String? intentId;
  String? created;
  bool? seen;

  NotificationModel(
      {this.id,
        this.message,
        this.thumbnail,
        this.type,
        this.intentId,
        this.created,
        this.seen});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    thumbnail = json['thumbnail'];
    intentId = json['intentId'];
    type = json['type'];
    created = json['created'];
    seen = json['seen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['message'] = this.message;
    data['type'] = this.type;
    data['thumbnail'] = this.thumbnail;
    data['intentId'] = this.intentId;
    data['created'] = this.created;
    data['seen'] = this.seen;
    return data;
  }
}