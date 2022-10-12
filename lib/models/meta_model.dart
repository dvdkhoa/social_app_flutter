class Meta {
  String? created;
  String? updated;
  Null? deleted;

  Meta({this.created, this.updated, this.deleted});

  Meta.fromJson(Map<String, dynamic> json) {
    created = json['created'];
    updated = json['updated'];
    deleted = json['deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created'] = this.created;
    data['updated'] = this.updated;
    data['deleted'] = this.deleted;
    return data;
  }
}