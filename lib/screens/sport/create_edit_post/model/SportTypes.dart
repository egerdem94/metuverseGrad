class SportTypes{
  static const List<String> sportTypeList = [
    'Football',
    'Basketball',
    'Volleyball',
    'Tennis',
    'Squash',
    'Mini Golf',
    'Chess',
    'Other',
  ];
  static int getIndexOfSportType(String sportType){
    for(var str in sportTypeList){
      if(str == sportType){
        return sportTypeList.indexOf(str);
      }
    }
    return -1;
  }
  static String getSport(int index){
    return sportTypeList[index];
  }
}