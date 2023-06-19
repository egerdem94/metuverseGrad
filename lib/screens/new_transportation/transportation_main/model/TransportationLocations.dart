class TransportationLocations{
  static const List<String> locationList = [
    'Campus',
    'Ercan',
    'Girne',
    'Güzelyurt',
    'Kalkanli',
    'Karpaz',
    'Lefke',
    'Lefkoşa',
    'Mağusa'
  ];
  static int getIndexOfLocation(String location){
    for(var str in locationList){
      if(str == location){
        return locationList.indexOf(str);
      }
    }
    return -1;
  }
  static String getLocation(int index){
    return locationList[index];
  }
}