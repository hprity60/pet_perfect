import 'package:fluttertoast/fluttertoast.dart';
import 'package:map_launcher/map_launcher.dart';

void openMapsForDirectionNow(double latitude, double longitude,String address) {
  Fluttertoast.showToast(msg: "Opening maps for place: $latitude $longitude");
  // MapsLauncher.launchCoordinates(latitude, longitude);
  // MapLauncher.launchQuery(address);
  // MapLauncher.showMarker(
  //   mapType: MapType.google,
  //   coords: (longitude),
  //   title: 'title',
  //   description: 'description',
  // );
}
