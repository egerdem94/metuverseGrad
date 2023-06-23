import 'package:metuverse/screens/profile/controller/ProfileBackendHelper.dart';
import 'package:metuverse/screens/profile/model/OtherUserProfileModel.dart';

class ProfileController{
  OtherUserProfileModel? otherUserProfileModel;
  ProfileBackendHelper profileBackendHelper = ProfileBackendHelper();
  Future<bool> getProfileInfo(relatedUserPublicToken) async{
    otherUserProfileModel = await profileBackendHelper.getProfileInfo(relatedUserPublicToken);
    if(otherUserProfileModel == null) return false;
    else return true;
  }
  Future<bool> addFriend(relatedUserPublicToken) async{
    bool isSuccessful = await profileBackendHelper.addFriend(relatedUserPublicToken);
    return isSuccessful;
  }
  Future<bool> removeFriend(relatedUserPublicToken) async{
    bool isSuccessful = await profileBackendHelper.removeFriend(relatedUserPublicToken);
    return isSuccessful;
  }
}