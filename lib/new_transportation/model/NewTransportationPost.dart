class NewTransportationPostList {
  List<NewTransportationPost>? posts;
  int? total;
  NewTransportationPostList({
    required this.posts,
    required this.total,
  });
  NewTransportationPostList.fromJson(Map<String, dynamic> json){
    posts = List.from(json['items']).map((e)=>NewTransportationPost.fromJson(e)).toList();
    total = json['total'];
  }
  NewTransportationPostList.dummy(){
    NewTransportationPost post1 = NewTransportationPost(
      belongToUser: true,
      fullName: "John Doe",
      profilePicture: "https://example.com/profile-picture.jpg",
      postID: 1000,
      updateVersion: 1,
      description: "Looking for a ride from NYC to Boston",
      departureID: 1,
      destinationID: 2,
      departureDate: "2023-04-05T12:00:00Z",
      availablePerson: 2,
      transportationPrice: 50,
      currency: "USD",
      transportationStatus: 0,
    );

    NewTransportationPost post2 = NewTransportationPost(
      belongToUser: false,
      fullName: "Jane Smith",
      profilePicture: "https://example.com/profile-picture.jpg",
      postID: 1002,
      updateVersion: 1,
      description: "Offering a ride from San Francisco to Los Angeles",
      departureID: 3,
      destinationID: 4,
      departureDate: "2023-04-10T08:00:00Z",
      availablePerson: 3,
      transportationPrice: 100,
      currency: "USD",
      transportationStatus: 1,
    );
    NewTransportationPost post3 = NewTransportationPost(
      belongToUser: true,
      fullName: "Megan Brown",
      profilePicture: "https://example.com/profile-picture.jpg",
      postID: 1003,
      updateVersion: 2,
      description: "Looking for someone to share a rental car from Miami to Orlando",
      departureID: 5,
      destinationID: 6,
      departureDate: "2023-04-07T10:00:00Z",
      availablePerson: 1,
      transportationPrice: 30,
      currency: "USD",
      transportationStatus: 0,
    );

    NewTransportationPost post4 = NewTransportationPost(
      belongToUser: false,
      fullName: "David Kim",
      profilePicture: "https://example.com/profile-picture.jpg",
      postID: 1004,
      updateVersion: 1,
      description: "Offering a private jet ride from Los Angeles to New York City",
      departureID: 7,
      destinationID: 8,
      departureDate: "2023-04-15T14:00:00Z",
      availablePerson: 4,
      transportationPrice: 5000,
      currency: "USD",
      transportationStatus: 2,
    );
    posts = [post1, post2,post3,post4];
    total = posts!.length;
  }
  NewTransportationPostList.dummy2(){
    NewTransportationPost post1 = NewTransportationPost(
      belongToUser: true,
      fullName: "Alexander Hamilton",
      profilePicture: "https://example.com/profile-picture.jpg",
      postID: 2000,
      updateVersion: 1,
      description: "4Levent'ten Kadıköy'e gidiyorum. 2 kişilik boş koltuk var.",
      departureID: 1,
      destinationID: 2,
      departureDate: "2023-04-05T12:00:00Z",
      availablePerson: 2,
      transportationPrice: 50,
      currency: "USD",
      transportationStatus: 0,
    );

    NewTransportationPost post2 = NewTransportationPost(
      belongToUser: false,
      fullName: "Thomas Edison",
      profilePicture: "https://example.com/profile-picture.jpg",
      postID: 2002,
      updateVersion: 1,
      description: "Yozgat'dan Ankara'ya gidiyorum. 3 kişilik boş koltuk var.",
      departureID: 3,
      destinationID: 4,
      departureDate: "2023-04-10T08:00:00Z",
      availablePerson: 3,
      transportationPrice: 100,
      currency: "USD",
      transportationStatus: 1,
    );
    NewTransportationPost post3 = NewTransportationPost(
      belongToUser: true,
      fullName: "Sabri Falyali",
      profilePicture: "https://example.com/profile-picture.jpg",
      postID: 1003,
      updateVersion: 2,
      description: "Looking for someone to share a rental car from Miami to Orlando",
      departureID: 5,
      destinationID: 6,
      departureDate: "2023-04-07T10:00:00Z",
      availablePerson: 1,
      transportationPrice: 30,
      currency: "USD",
      transportationStatus: 0,
    );

    NewTransportationPost post4 = NewTransportationPost(
      belongToUser: false,
      fullName: "Abidin Duzgun",
      profilePicture: "https://example.com/profile-picture.jpg",
      postID: 1004,
      updateVersion: 1,
      description: "Offering a private jet ride from Los Angeles to New York City",
      departureID: 7,
      destinationID: 8,
      departureDate: "2023-04-15T14:00:00Z",
      availablePerson: 4,
      transportationPrice: 5000,
      currency: "USD",
      transportationStatus: 2,
    );
    posts = [post1, post2,post3,post4];
    total = posts!.length;
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
}

class NewTransportationPost {
  NewTransportationPost({
    required this.belongToUser,
    required this.fullName,
    required this.profilePicture,
    required this.postID,
    required this.updateVersion,
    required this.description,
    required this.departureID,
    required this.destinationID,
    required this.departureDate,
    required this.availablePerson,
    required this.transportationPrice,
    required this.currency,
    required this.transportationStatus,
  });
  bool? belongToUser;
  String? fullName;
  String? profilePicture;
  int? postID;
  int? updateVersion;
  String? description;
  int? departureID;
  int? destinationID;
  String? departureDate;
  int? availablePerson;
  int? transportationPrice;
  String? currency;
  int? transportationStatus;

  NewTransportationPost.fromJson(Map<String, dynamic> json){
    belongToUser = json['belongToUser'];
    fullName = json['fullName'];
    profilePicture = json['profilePicture'];
    postID = json['postID'];
    updateVersion = json['updateVersion'];
    description = json['description'];
    departureID = json['departureID'];
    destinationID = json['destinationID'];
    departureDate = json['departureDate'];
    availablePerson = json['availablePerson'];
    transportationPrice = json['transportationPrice'];
    currency = null;
    transportationStatus = json['transportationStatus'];
  }

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