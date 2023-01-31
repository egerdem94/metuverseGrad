class PostsToDisplay {
  List<PostToDisplay>? postsToDisplayList;
  int? total;
  bool? processStatus;
  int? messageID;

  PostsToDisplay({this.postsToDisplayList, this.total, this.processStatus, this.messageID});

  PostsToDisplay.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      postsToDisplayList = <PostToDisplay>[];
      json['items'].forEach((v) {
        postsToDisplayList!.add(new PostToDisplay.fromJson(v));
      });
    }
    total = json['total'];
    processStatus = json['processStatus'];
    messageID = json['messageID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.postsToDisplayList != null) {
      data['items'] = this.postsToDisplayList!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    data['processStatus'] = this.processStatus;
    data['messageID'] = this.messageID;
    return data;
  }
}

class PostToDisplay {
  int? postID;
  int? updateVersion;

  PostToDisplay({this.postID, this.updateVersion});

  PostToDisplay.fromJson(Map<String, dynamic> json) {
    postID = json['postID'];
    updateVersion = json['updateVersion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postID'] = this.postID;
    data['updateVersion'] = this.updateVersion;
    return data;
  }
}