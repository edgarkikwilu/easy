class UserLocation{
  final String name;
  final double lat;
  final double lng;

  UserLocation(this.name,this.lat,this.lng);

  static List<UserLocation> initPickupLocation(){
    List<UserLocation> list = [
      UserLocation("Home", -6.786390, 39.160030),
      UserLocation("Smartcodes", -6.776012, 39.178326),
      UserLocation("Goba", -6.742547, 39.161862)
    ];
    return list;
  }

  static initDestinationLocation(){
    List<UserLocation> list = [
      UserLocation("Kidimbwi", -6.708629, 39.232583),
      UserLocation("Koffee Kaffee", -6.814920, 39.288410),
      UserLocation("Tegeta", -6.663340, 39.181370)
    ];
    return list;
  }
}