import 'package:metuverse/screens/new_transportation/transportation_main/controller/storage/database/TransportationPostTableValues.dart';
import 'package:metuverse/storage/models/BasePost.dart';

class TransportationPostList extends BasePostList<TransportationPost>{
  bool nothingFound = false;

  TransportationPostList.nothingFound()
      : super.defaults() {
    this.nothingFound = true;
  }

  TransportationPostList.defaults(): super.defaults();

  TransportationPostList.fromJson(Map<String, dynamic> json)
      : super.defaults() {
    if (json['items'] != null) {
      this.posts = <TransportationPost>[];
      json['items'].forEach((v) {
        this.posts!.add(new TransportationPost.fromJson(v));
      });
    }
    this.total = json['total'];
  }

  TransportationPostList.fromDbMap(List<Map<String, dynamic>> json)
      : super.defaults() {
    this.posts = <TransportationPost>[];
    json.forEach((v) {
      this.posts!.add(new TransportationPost.fromDbMap(v));
    });
  }
}
class TransportationPost extends BasePost{
  int? departureID;
  int? destinationID;
  String? departureDate;
  int? availablePerson;
  int? totalPerson;
  int? transportationPrice;
  String? currency;
  int? transportationStatus;
  
  TransportationPost({
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
  TransportationPost.fromDbMap(Map<String, dynamic> json)
      : departureID = json[TransportationPostTableValues.columnDepartureLocation],
        destinationID = json[TransportationPostTableValues.columnDestinationLocation],
        departureDate = json[TransportationPostTableValues.columnDepartureTime],
        availablePerson = json[TransportationPostTableValues.columnAvailablePerson],
        totalPerson = json[TransportationPostTableValues.columnTotalPerson],
        transportationPrice = json[TransportationPostTableValues.columnProductPrice],
        currency = json[TransportationPostTableValues.columnCurrency],
        transportationStatus = json[TransportationPostTableValues.columnTransportationStatus],
        super(
        belongToUser: json[TransportationPostTableValues.columnBelongToUser] == 1
            ? true
            : false,
        isFavorite: json[TransportationPostTableValues.columnIsFavorite] == 1
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
    _data[TransportationPostTableValues.columnIsFavorite] = isFavorite == true ? 1 : 0;
    _data[TransportationPostTableValues.columnFullName] = fullName;
    _data[TransportationPostTableValues.columnProfilePicture] = profilePicture;
    _data[TransportationPostTableValues.columnPostID] = postID;
    _data[TransportationPostTableValues.columnUpdateVersion] = updateVersion;
    _data[TransportationPostTableValues.columnDescription] = description;
    _data[TransportationPostTableValues.columnDepartureLocation] = departureID;
    _data[TransportationPostTableValues.columnDestinationLocation] = destinationID;
    _data[TransportationPostTableValues.columnDepartureTime] = departureDate;
    _data[TransportationPostTableValues.columnAvailablePerson] = availablePerson;
    _data[TransportationPostTableValues.columnTotalPerson] = totalPerson;
    _data[TransportationPostTableValues.columnProductPrice] = transportationPrice;
    _data[TransportationPostTableValues.columnCurrency] = currency;
    _data[TransportationPostTableValues.columnTransportationStatus] = transportationStatus;
    return _data;
  }
  TransportationPost.fromJson(Map<String, dynamic> json)
      : departureID = json['departureID'],
        destinationID = json['destinationID'],
        departureDate = json['departureDate'],
        availablePerson = json['availablePerson'],
        totalPerson = json['totalPerson'],
        transportationPrice = json['transportationPrice'],
        currency = json['currency'],
        transportationStatus = json['transportationStatus'],
        super(
        belongToUser: json['belongToUser'],
        isFavorite: json['isFavorite'],
        publicToken: json['publicToken'],
        fullName: json['fullName'],
        profilePicture: json['profilePicture'],
        postID: json['postID'],
        updateVersion: json['updateVersion'],
        description: json['description'],
      );
}