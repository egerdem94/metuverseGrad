import 'package:flutter/material.dart';
import 'package:metuverse/screens/new_transportation/controller/storage/backend/BackendHelperTransportation.dart';
import 'package:metuverse/screens/new_transportation/controller/storage/database/DatabaseHelperTransportation.dart';
import 'package:metuverse/screens/new_transportation/model/NewTransportationPost.dart';
import 'package:metuverse/storage/models/PostsToDisplay.dart';

class TransportationPostHandler{
  final dbHelper = DatabaseHelperTransportation();
  final backendHelper = BackendHelperTransportation();
  bool initialized = false;

  NewTransportationPostList customerPostList = NewTransportationPostList.defaults();
  NewTransportationPostList driverPostList = NewTransportationPostList.defaults();

  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await dbHelper.init();
    initialized = true;
  }

  List<int> convertIdList(postIDListAsString){
    List<int> convertedList = [];
    if(postIDListAsString == "")
      return convertedList;
    var stringList = postIDListAsString.split(',');
    stringList.removeAt(0); //removing empty element located in first index
    for(var str in stringList){
      convertedList.add(int.parse(str));
    }
    return convertedList;
  }

  String getLastPostID(customerOrDriver,firstTime){
    var lastPostID = '';
    if(!firstTime){
      if(customerOrDriver == 'c'){
        lastPostID = customerPostList.getLastPostID().toString();
      }
      else{
        lastPostID = driverPostList.getLastPostID().toString();
      }
    }
    return lastPostID;
  }
  bool isEmpty(customerOrDriver){
    if(customerOrDriver == 'c'){
      if(customerPostList.isEmpty()){
        return true;
      }
      else{
        return false;
      }
    }
    else{
      if(driverPostList.isEmpty()){
        return true;
      }
      else{
        return false;
      }
    }
  }
  int getLength(buyOrSell){
    if(buyOrSell == 'c'){
      return customerPostList.length();
    }
    else{
      return driverPostList.length();
    }
  }

  /// This method is used to prepare the posts that are going to be requested as string.
  ///*/
  Future<List<String>> preparePostToRequestString(PostsToDisplay? postsToDisplay) async {
    //await _query();
    var postsToBeAsked = await dbHelper.getNeededPostIdList(postsToDisplay);
    String postsToBeAskedBackendIDList = '';
    for(int i = 0; i < postsToBeAsked[0].length; i++){
      postsToBeAskedBackendIDList += ','; //add comma before each postID
      postsToBeAskedBackendIDList += postsToBeAsked[0][i].toString();
    }
    String postsToBeAskedLocalDB = '';
    for(int i = 0; i < postsToBeAsked[1].length; i++){
      postsToBeAskedLocalDB += ','; //add comma before each postID
      postsToBeAskedLocalDB += postsToBeAsked[1][i].toString();
    }
    return [postsToBeAskedBackendIDList,postsToBeAskedLocalDB];
  }



  Future<bool> handlePostList(customerOrDriver,firstTime) async{
    PostsToDisplay? postsToDisplay;
    if(firstTime){
      customerPostList = NewTransportationPostList.defaults();
      driverPostList = NewTransportationPostList.defaults();
    }
    //postsToDisplay = await _request_posts_to_diplay(buyOrSell,firstTime);
    postsToDisplay = await backendHelper.requestPostsToDisplay(customerOrDriver,getLastPostID(customerOrDriver, firstTime));
    List<String> postsToBeAsked = await preparePostToRequestString(postsToDisplay);
    //List<int> idListOfPostsForPhotos = postIDListHandlingForPhotos(postsToBeAsked); //for photo process
    //await _requestPostsFromBackend(postsToBeAsked[0],buyOrSell);
    //await _request_buy_sell_posts_from_localdb(postsToBeAsked[1],buyOrSell);
    if(customerOrDriver == 'c'){
      NewTransportationPostList? tempPostList = (await backendHelper.getPostsFromBackend(postsToBeAsked[0])) as NewTransportationPostList?;
      if(tempPostList != null){
        customerPostList.addNewPosts(tempPostList);
        tempPostList.posts!.forEach((element) async {
          final id = await dbHelper.insertNewTransportationPost(element);
          //debugPrint('inserted row id: $id');
        });

      }
      NewTransportationPostList? tempPostList2 = (await dbHelper.getPostsFromLocalDB(convertIdList(postsToBeAsked[1]))) as NewTransportationPostList?;

      if(tempPostList2 != null){
        customerPostList.addNewPosts(tempPostList2);
      }
      if(customerPostList.isEmpty()){
        return false;
      }
      else{
        //await handlePhotoList(buyOrSell,idListOfPostsForPhotos);
        return true;
      }
    }
    else if(customerOrDriver == 'd'){
      NewTransportationPostList? tempPostList = (await backendHelper.getPostsFromBackend(postsToBeAsked[0])) as NewTransportationPostList?;
      if(tempPostList != null){
        driverPostList.addNewPosts(tempPostList);
        tempPostList.posts!.forEach((element) async {
          final id = await dbHelper.insertNewTransportationPost(element);
          //debugPrint('inserted row id: $id');
        });

      }
      NewTransportationPostList? tempPostList2 = (await dbHelper.getPostsFromLocalDB(convertIdList(postsToBeAsked[1]))) as NewTransportationPostList?;

      if(tempPostList2 != null){
        driverPostList.addNewPosts(tempPostList2);
      }
      if(driverPostList.isEmpty()){
        return false;
      }
      else{
        return true;
      }
    }
    else{
      print('Error in TransportationPostHandler.dart Unexpected customerOrDriver value');
      return false;
    }
  }
  NewTransportationPostList? getTransportationPostList(customerOrDriver){
    if(customerOrDriver == 'c'){
      return customerPostList;
    }
    else if(customerOrDriver == 'd'){
      return driverPostList;
    }
    else{
      print('Error in TransportationPostHandler.dart Unexpected buyOrSell value');
      return null;
    }
  }
  Future handleSearchPosts(searchKey,departureLocation,destinationLocation,customerOrDriver) async{
    NewTransportationPostList? tempSearchedPostList = await backendHelper.requestSearchPosts(searchKey,departureLocation,destinationLocation,customerOrDriver);
    if(customerOrDriver == 'c'){
      customerPostList = tempSearchedPostList!;
    }
    else if(customerOrDriver == 'd'){
      driverPostList = tempSearchedPostList!;
    }
    else{
      print('Error in TransportationPostHandler.dart Unexpected buyOrSell value');
    }

  }
}