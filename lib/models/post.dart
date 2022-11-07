class PostModel {
  String? id;
  By? by;
  int? type;
  Meta? meta;
  Detail? detail;
  List<Comments>? comments;
  List<Likes>? likes;

  PostModel(
      {this.id,
        this.by,
        this.type,
        this.meta,
        this.detail,
        this.comments,
        this.likes});

  PostModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    by = json['by'] != null ? new By.fromJson(json['by']) : null;
    type = json['type'];
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    detail =
    json['detail'] != null ? new Detail.fromJson(json['detail']) : null;
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(new Comments.fromJson(v));
      });
    }
    if (json['likes'] != null) {
      likes = <Likes>[];
      json['likes'].forEach((v) {
        likes!.add(new Likes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.by != null) {
      data['by'] = this.by!.toJson();
    }
    data['type'] = this.type;
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    if (this.detail != null) {
      data['detail'] = this.detail!.toJson();
    }
    if (this.comments != null) {
      data['comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    if (this.likes != null) {
      data['likes'] = this.likes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class By {
  String? id;
  String? name;
  String? image;
  String? gender;

  By({this.id, this.name, this.image, this.gender});

  By.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['gender'] = this.gender;
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

class Detail {
  String? text;
  List<PostFiles>? postFiles;

  Detail({this.text, this.postFiles});

  Detail.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    if (json['postFiles'] != null) {
      postFiles = <PostFiles>[];
      json['postFiles'].forEach((v) {
        postFiles!.add(new PostFiles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    if (this.postFiles != null) {
      data['postFiles'] = this.postFiles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PostFiles {
  String? id;
  String? url;
  int? fileType;

  PostFiles({this.id, this.url, this.fileType});

  PostFiles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    fileType = json['fileType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['fileType'] = this.fileType;
    return data;
  }
}

class Comments {
  By? by;
  String? ts;
  String? text;

  Comments({this.by, this.ts, this.text});

  Comments.fromJson(Map<String, dynamic> json) {
    by = json['by'] != null ? new By.fromJson(json['by']) : null;
    ts = json['ts'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.by != null) {
      data['by'] = this.by!.toJson();
    }
    data['ts'] = this.ts;
    data['text'] = this.text;
    return data;
  }
}

class Likes {
  By? by;
  String? ts;

  Likes({this.by, this.ts});

  Likes.fromJson(Map<String, dynamic> json) {
    by = json['by'] != null ? new By.fromJson(json['by']) : null;
    ts = json['ts'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.by != null) {
      data['by'] = this.by!.toJson();
    }
    data['ts'] = this.ts;
    return data;
  }
}
