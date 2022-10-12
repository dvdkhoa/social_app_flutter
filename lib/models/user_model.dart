import 'package:ltp/models/profile_model.dart';

import 'followers_model.dart';
import 'meta_model.dart';

class User {
  Profile? profile;
  Followers? followers;
  String? id;
  Meta? meta;

  User({this.profile, this.followers, this.id, this.meta});

  User.fromJson(Map<String, dynamic> json) {
    profile = json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
    followers = json['followers'] != null ? new Followers.fromJson(json['followers']) : null;
    id = json['id'];
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    if (this.followers != null) {
      data['followers'] = this.followers!.toJson();
    }
    data['id'] = this.id;
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    return data;
  }
}