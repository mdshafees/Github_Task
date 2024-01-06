// ignore_for_file: file_names

class ModelClass {
  String? login;
  int? id;
  String? nodeId;
  String? url;
  String? reposUrl;
  String? eventsUrl;
  String? hooksUrl;
  String? issuesUrl;
  String? membersUrl;
  String? publicMembersUrl;
  String? avatarUrl;
  Null description;

  ModelClass(
      {this.login,
      this.id,
      this.nodeId,
      this.url,
      this.reposUrl,
      this.eventsUrl,
      this.hooksUrl,
      this.issuesUrl,
      this.membersUrl,
      this.publicMembersUrl,
      this.avatarUrl,
      this.description});

  ModelClass.fromJson(Map<String, dynamic> json) {
    login = json['login'];
    id = json['id'];
    nodeId = json['node_id'];
    url = json['url'];
    reposUrl = json['repos_url'];
    eventsUrl = json['events_url'];
    hooksUrl = json['hooks_url'];
    issuesUrl = json['issues_url'];
    membersUrl = json['members_url'];
    publicMembersUrl = json['public_members_url'];
    avatarUrl = json['avatar_url'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['login'] = login;
    data['id'] = id;
    data['node_id'] =nodeId;
    data['url'] = url;
    data['repos_url'] = reposUrl;
    data['events_url'] = eventsUrl;
    data['hooks_url'] = hooksUrl;
    data['issues_url'] = issuesUrl;
    data['members_url'] = membersUrl;
    data['public_members_url'] = publicMembersUrl;
    data['avatar_url'] = avatarUrl;
    data['description'] = description;
    return data;
  }
}

class BaseModel {}

class Profile {
  Profile({
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
  });

  String? phone;
  String? name;
  String? email;
  String? image;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        name: json["name"],
        email: json["email"],
        image: json["image"],
        phone: json["status"],
      );

  Map<String, dynamic> toJson() =>
      {"name": name, "email": email, "phone": phone, "image": image};
}
