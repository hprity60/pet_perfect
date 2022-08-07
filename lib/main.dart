import 'package:flutter/foundation.dart';
import 'package:pet_perfect_app/app.dart';
import 'package:flutter/widgets.dart';
import 'package:pet_perfect_app/common/models/user_data.dart';
import 'package:pet_perfect_app/utils/shared_preferences.dart';
import './utils/local_db_hive.dart';
import 'package:geolocator/geolocator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Geolocator
  // await Geolocator.requestPermission();
  await LocalDb.init();

  // await Preferences.init();
  // LocalDb.clearUserData();
  UserData.init();
  runApp(MyApp());
}
