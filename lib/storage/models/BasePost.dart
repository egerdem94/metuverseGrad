import 'package:metuverse/storage/models/Photo.dart';

import 'package:flutter/material.dart';

abstract class BasePostList<T extends BasePost> {
  List<T>? posts;
  int? total;

  BasePostList({
    this.posts,
    this.total,
  });

  BasePostList.defaults() {
    this.posts = [];
    this.total = 0;
  }

  bool isEmpty() {
    if (this.posts == null || this.posts!.length == 0)
      return true;
    else
      return false;
  }

  void sortListByPostID() {
    this.posts!.sort((b, a) => a.postID!.compareTo(b.postID!));
  }

  T? getPostWithID(int id) {
    if (this.posts == null) {
      return null;
    }
    for (var post in this.posts!) {
      if (id == post.postID) {
        return post;
      }
    }
    return null;
  }

  void addNewPosts(BasePostList<T> newPosts) {
    newPosts.posts!.forEach((element) {
      addNewPost(element);
    });
    sortListByPostID();
  }

  void addNewPost(T newPost) {
    bool postIDAlreadyExists = false;
    bool postIDAlreadyExistsButUpdated = false;
    this.posts!.forEach((element) {
      if (newPost.postID == element.postID) {
        if (element.updateVersion! > newPost.updateVersion!) {
          postIDAlreadyExistsButUpdated = true;
        } else {
          postIDAlreadyExists = true;
        }
      }
    });
    if (!postIDAlreadyExists) {
      this.posts!.add(newPost);
    } else if (postIDAlreadyExistsButUpdated) {
      for (int i = 0; i < this.posts!.length; i++) {
        if (this.posts![i].postID == newPost.postID) {
          this.posts![i] = newPost;
        }
      }
    }
  }

  void deletePost(int postID) {
    this.posts!.removeWhere((element) => element.postID == postID);
  }

  int getLastPostID() {
    sortListByPostID();
    return this.posts!.last.postID!;
  }

  int length() {
    if (this.posts == null) {
      return 0;
    } else {
      return this.posts!.length;
    }
  }
}

class BasePost{
  static const String defaultProfilePictureUrl =
      "http://birikikoli.com/images/blank-profile-picture.jpg"; //empty profile picture
  bool? belongToUser;
  bool? isFavorite;
  String? fullName;
  String? profilePicture;
  int? postID;
  int? updateVersion;
  String? description;
  String? publicToken;

  BasePost({
    this.belongToUser,
    this.isFavorite,
    this.fullName,
    this.profilePicture,
    this.postID,
    this.updateVersion,
    this.description,
    this.publicToken,
  });
  String getProfilePicture() {
    return this.profilePicture ?? defaultProfilePictureUrl;
  }
}