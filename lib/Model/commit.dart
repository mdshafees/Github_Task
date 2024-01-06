class BranchCommit {
  String? sha;
  String? nodeId;
  Commit? commit;

  BranchCommit({this.sha, this.nodeId, this.commit});

  BranchCommit.fromJson(Map<String, dynamic> json) {
    sha = json['sha'];
    nodeId = json['node_id'];
    commit =
        json['commit'] != null ? Commit.fromJson(json['commit']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sha'] = sha;
    data['node_id'] = nodeId;
    if (commit != null) {
      data['commit'] = commit!.toJson();
    }
    return data;
  }
}

class Commit {
  Author? author;
  Author? committer;
  String? message;

  Commit({this.author, this.committer, this.message});

  Commit.fromJson(Map<String, dynamic> json) {
    author =
        json['author'] != null ? Author.fromJson(json['author']) : null;
    committer = json['committer'] != null
        ? Author.fromJson(json['committer'])
        : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (author != null) {
      data['author'] = author!.toJson();
    }
    if (committer != null) {
      data['committer'] = committer!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class Author {
  String? name;
  String? email;
  String? date;

  Author({this.name, this.email, this.date});

  Author.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['date'] = date;
    return data;
  }
}
