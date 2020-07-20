
import 'package:location/location.dart';
import 'package:mahua_pet/utils/utils_index.dart';

class TKLocation {

  static Future<void> getLocation() async {
    Location _location = new Location();
    LocationData _locationData;

    PermissionStatus status = await _location.requestPermission();
    if (status == PermissionStatus.granted) {
      _locationData = await _location.getLocation();
      print(_locationData.toString());
    } 
  } 
  
}