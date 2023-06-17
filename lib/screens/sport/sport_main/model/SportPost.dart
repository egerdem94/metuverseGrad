import 'package:metuverse/storage/models/BasePost.dart';


class SportPostList extends BasePostList<SportPost>{
  String? message;

  SportPostList.fromJson(Map<String, dynamic> json)
      : super.defaults() {
    if (json['items'] != null) {
      this.posts = <SportPost>[];
      json['items'].forEach((v) {
        this.posts!.add(new SportPost.fromJson(v));
      });
    }
    this.total = json['total'];
    this.message = json['message'];
  }

  SportPostList.defaults(): super.defaults() {
    this.posts = <SportPost>[
      SportPost(
          belongToUser: true,
          publicToken: 'publicToken1',
          fullName: 'John Doe',
          profilePicture: 'https://w0.peakpx.com/wallpaper/979/89/HD-wallpaper-purple-smile-design-eye-smily-profile-pic-face.jpg',
          postID: 1,
          updateVersion: 1,
          description: 'This is a great sport event!',
          sportID: 1,
          eventDate: '2023-07-01',
          availablePerson: 5,
          currentPerson: 3,
          sportmateStatus: 1,
          createDate: '2023-06-01'),
      SportPost(
          belongToUser: false,
          publicToken: 'publicToken1',
          fullName: 'Salih Doe',
          profilePicture: 'https://w0.peakpx.com/wallpaper/979/89/HD-wallpaper-purple-smile-design-eye-smily-profile-pic-face.jpg',
          postID: 1,
          updateVersion: 1,
          description: 'This is a great sport event!',
          sportID: 2,
          eventDate: '2023-07-01',
          availablePerson: 5,
          currentPerson: 3,
          sportmateStatus: 1,
          createDate: '2023-06-01'),
      SportPost(
          belongToUser: false,
          publicToken: 'publicToken1',
          fullName: 'Ekrem Doe',
          profilePicture: 'https://w0.peakpx.com/wallpaper/979/89/HD-wallpaper-purple-smile-design-eye-smily-profile-pic-face.jpg',
          postID: 1,
          updateVersion: 1,
          description: 'This is a great sport event!',
          sportID: 3,
          eventDate: '2023-07-01',
          availablePerson: 5,
          currentPerson: 3,
          sportmateStatus: 1,
          createDate: '2023-06-01'),
      SportPost(
          belongToUser: false,
          publicToken: 'publicToken1',
          fullName: 'Kemal Doe',
          profilePicture: 'https://w0.peakpx.com/wallpaper/979/89/HD-wallpaper-purple-smile-design-eye-smily-profile-pic-face.jpg',
          postID: 1,
          updateVersion: 1,
          description: 'This is a great sport event!',
          sportID: 4,
          eventDate: '2023-07-01',
          availablePerson: 5,
          currentPerson: 3,
          sportmateStatus: 1,
          createDate: '2023-06-01'),
      SportPost(
          belongToUser: false,
          publicToken: 'publicToken1',
          fullName: 'Meral Doe',
          profilePicture: 'https://w0.peakpx.com/wallpaper/979/89/HD-wallpaper-purple-smile-design-eye-smily-profile-pic-face.jpg',
          postID: 1,
          updateVersion: 1,
          description: 'This is a great sport event!',
          sportID: 5,
          eventDate: '2023-07-01',
          availablePerson: 5,
          currentPerson: 3,
          sportmateStatus: 1,
          createDate: '2023-06-01'),
    ];
    this.total = this.posts!.length;
  }
}
class SportPost extends BasePost {

  int? sportID;
  String? eventDate;
  int? availablePerson;
  int? currentPerson;
  int? sportmateStatus;
  String? createDate;

  SportPost(
      {super.belongToUser,
        super.publicToken,
        super.fullName,
        super.profilePicture,
        super.postID,
        super.updateVersion,
        super.description,
        this.sportID,
        this.eventDate,
        this.availablePerson,
        this.currentPerson,
        this.sportmateStatus,
        this.createDate});

  SportPost.fromJson(Map<String, dynamic> json) {
    belongToUser = json['belongToUser'];
    publicToken = json['publicToken'];
    fullName = json['fullName'];
    profilePicture = json['profilePicture'];
    postID = json['postID'];
    updateVersion = json['updateVersion'];
    description = json['description'];
    sportID = json['sportID'];
    eventDate = json['eventDate'];
    availablePerson = json['availablePerson'];
    currentPerson = json['currentPerson'];
    sportmateStatus = json['sportmateStatus'];
    createDate = json['createDate'];
  }
}
