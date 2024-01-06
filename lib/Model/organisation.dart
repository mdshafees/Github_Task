class Organisation {

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

  Organisation(
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
      });

  Organisation.fromJson(Map<String, dynamic> json) {

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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['login'] = login;
    data['id'] = id;
    data['node_id'] = nodeId;
    data['url'] = url;
    data['repos_url'] = reposUrl;
    data['events_url'] = eventsUrl;
    data['hooks_url'] = hooksUrl;
    data['issues_url'] = issuesUrl;
    data['members_url'] = membersUrl;
    data['public_members_url'] = publicMembersUrl;
    data['avatar_url'] = avatarUrl;
    return data;
  }
}
