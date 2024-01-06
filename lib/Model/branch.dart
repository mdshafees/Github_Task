class Branch {
  String? name;
  Commit? commit;
  bool? protected;

  Branch({this.name, this.commit, this.protected});

  Branch.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    commit = json['commit'] != null ? Commit.fromJson(json['commit']) : null;
    protected = json['protected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    if (commit != null) {
      data['commit'] = commit!.toJson();
    }
    data['protected'] = protected;
    return data;
  }
}

class Commit {
  String? sha;
  String? url;

  Commit({this.sha, this.url});

  Commit.fromJson(Map<String, dynamic> json) {
    sha = json['sha'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sha'] = sha;
    data['url'] = url;
    return data;
  }
}
