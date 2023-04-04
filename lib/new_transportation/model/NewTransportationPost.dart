import 'package:metuverse/new_transportation/controller/storage/database/TransportationPostTableValues.dart';
import 'package:metuverse/storage/models/BasePost.dart';

class NewTransportationPostList extends BasePostList{
  List<NewTransportationPost>? posts;
  int? total;
  NewTransportationPostList({
    required this.posts,
    required this.total,
  });
  NewTransportationPostList.defaults()
      : posts = [],
        total = 0;
  NewTransportationPostList.fromJson(Map<String, dynamic> json){
    posts = List.from(json['items']).map((e)=>NewTransportationPost.fromJson(e)).toList();
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    if(posts == null){
      return <String, dynamic>{};
    }
    final _data = <String, dynamic>{};
    _data['items'] = posts!.map((e)=>e.toJson()).toList();
    _data['total'] = total;
    return _data;
  }

  void addAllXX(NewTransportationPostList tempList) {
    if(posts == null){
      posts = [];
    }
    if(tempList.posts == null){
      return;
    }
    for(NewTransportationPost post in tempList.posts!){
      posts!.add(post);
    }
  }

  int length() {
    if(posts == null){
      return 0;
    }
    return posts!.length;
  }

  void sortListByPostID(){
    posts!.sort((b, a) => a.postID!.compareTo(b.postID!));
  }

  int getLastPostID(){
    sortListByPostID();
    return posts!.last.postID!;
  }

  bool isEmpty(){
    if(posts == null || posts!.length == 0)
      return true;
    else
      return false;
  }

  void addNewPosts(NewTransportationPostList newPosts){
    newPosts.posts!.forEach((element) {
      addNewPost(element);
    });
    sortListByPostID();// IMPORTANT! This might be a bad idea. You might do ordering while inserting!
  }

  void addNewPost(NewTransportationPost newPost){
    bool postIDAlreadyExists = false;
    bool postIDAlreadyExistsButUpdated = false;
    posts!.forEach((newElement) {
      if(newPost.postID == newElement.postID){
        if(newElement.updateVersion! > newPost.updateVersion!){
          postIDAlreadyExistsButUpdated = true;
        }
        else{
          postIDAlreadyExists = true;
        }
      }
    });
    if(!postIDAlreadyExists){
      posts!.add(newPost);
    }
    else if(postIDAlreadyExistsButUpdated){
      //replace the old post with the new one
      for(int i = 0; i < posts!.length; i++){
        if(posts![i].postID == newPost.postID){
          posts![i] = newPost;
        }
      }
    }
  }
}

class NewTransportationPost extends BasePost{
  int? departureID;
  int? destinationID;
  String? departureDate;
  int? availablePerson;
  int? transportationPrice;
  String? currency;
  int? transportationStatus;
  
  NewTransportationPost({
    bool? belongToUser,
    String? fullName,
    String? profilePicture,
    int? postID,
    int? updateVersion,
    String? description,
    this.departureID,
    this.destinationID,
    this.departureDate,
    this.availablePerson,
    this.transportationPrice,
    this.currency,
    this.transportationStatus,
  }) : super(
    belongToUser: belongToUser,
    fullName: fullName,
    profilePicture: profilePicture,
    postID: postID,
    updateVersion: updateVersion,
    description: description,
  );
  NewTransportationPost.fromDbMap(Map<String, dynamic> json)
      : departureID = json[TransportationPostTableValues.columnDepartureLocation],
        destinationID = json[TransportationPostTableValues.columnDestinationLocation],
        departureDate = json[TransportationPostTableValues.columnDepartureTime],
        availablePerson = json[TransportationPostTableValues.columnPassengerCount],
        transportationPrice = json[TransportationPostTableValues.columnProductPrice],
        currency = json[TransportationPostTableValues.columnCurrency],
        transportationStatus = json[TransportationPostTableValues.columnTransportationStatus],
        super(
        belongToUser: json[TransportationPostTableValues.columnBelongToUser] == 1
            ? true
            : false,
        fullName: json[TransportationPostTableValues.columnFullName],
        profilePicture: json[TransportationPostTableValues.columnProfilePicture],
        postID: json[TransportationPostTableValues.columnPostID],
        updateVersion: json[TransportationPostTableValues.columnUpdateVersion],
        description: json[TransportationPostTableValues.columnDescription],
      );
  Map<String,dynamic> toDbMap(){
    final _data = <String, dynamic>{};
    _data[TransportationPostTableValues.columnBelongToUser] = belongToUser == true ? 1 : 0;
    _data[TransportationPostTableValues.columnFullName] = fullName;
    _data[TransportationPostTableValues.columnProfilePicture] = profilePicture;
    _data[TransportationPostTableValues.columnPostID] = postID;
    _data[TransportationPostTableValues.columnUpdateVersion] = updateVersion;
    _data[TransportationPostTableValues.columnDescription] = description;
    _data[TransportationPostTableValues.columnDepartureLocation] = departureID;
    _data[TransportationPostTableValues.columnDestinationLocation] = destinationID;
    _data[TransportationPostTableValues.columnDepartureTime] = departureDate;
    _data[TransportationPostTableValues.columnPassengerCount] = availablePerson;
    _data[TransportationPostTableValues.columnProductPrice] = transportationPrice;
    _data[TransportationPostTableValues.columnCurrency] = currency;
    _data[TransportationPostTableValues.columnTransportationStatus] = transportationStatus;
    return _data;
  }
  NewTransportationPost.fromJson(Map<String, dynamic> json)
      : departureID = json['departureID'],
        destinationID = json['destinationID'],
        departureDate = json['departureDate'],
        availablePerson = json['availablePerson'],
        transportationPrice = json['transportationPrice'],
        currency = json['currency'],
        transportationStatus = json['transportationStatus'],
        super(
        belongToUser: json['belongToUser'],
        fullName: json['fullName'],
        profilePicture: json['profilePicture'],
        postID: json['postID'],
        updateVersion: json['updateVersion'],
        description: json['description'],
      );
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['belongToUser'] = belongToUser;
    _data['fullName'] = fullName;
    _data['profilePicture'] = profilePicture;
    _data['postID'] = postID;
    _data['updateVersion'] = updateVersion;
    _data['description'] = description;
    _data['departureID'] = departureID;
    _data['destinationID'] = destinationID;
    _data['departureDate'] = departureDate;
    _data['availablePerson'] = availablePerson;
    _data['transportationPrice'] = transportationPrice;
    _data['currency'] = currency;
    _data['transportationStatus'] = transportationStatus;
    return _data;
  }
}