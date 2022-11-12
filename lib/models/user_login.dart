class User {
  String? userId;
  Meta? meta;
  Profile? profile;

  User({this.userId, this.meta, this.profile});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    profile =
    json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    return data;
  }
}

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

class Profile {
  String? name;
  String? image;
  Null? background;
  String? gender;

  Profile({this.name, this.image, this.background, this.gender});

  Profile.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    background = json['background'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    data['background'] = this.background;
    data['gender'] = this.gender;
    return data;
  }
}