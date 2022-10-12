class Profile {
  String? name;
  String? image;
  String? gender;

  Profile({this.name, this.image, this.gender});

  Profile.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    data['gender'] = this.gender;
    return data;
  }
}
