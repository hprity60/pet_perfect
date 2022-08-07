// import 'dart:convert';

// import 'package:shared_preferences/shared_preferences.dart';

// enum PREFS_KEYS {
//   PHONE_NUMBER,
//   FIRST_NAME,
//   LAST_NAME,
//   ACCESS_TOKEN,
//   REFRESH_TOKEN,
//   TOKEN_EXPIRY,
//   AUTHENTICATION_STATUS,
//   PET_ID,
// }

// class Preferences {
//   static SharedPreferences preferences;
//   static const String KEY_SELECTED_THEME = 'key_selected_theme';
//   static init() async {
//     preferences = await SharedPreferences.getInstance();
//   }

//   static Future<void> saveKey(PREFS_KEYS key, String val) async {
//     String valEncoded = jsonEncode(val);
//     await preferences.setString(key.toString(), valEncoded);
//   }

//   static String getKey(PREFS_KEYS key) {
//     String encodedVal = preferences.getString(key.toString());
//     if (null == encodedVal) return null;
//     return jsonDecode(encodedVal);
//   }

//   static Future<void> removeKey(PREFS_KEYS key) async {
//     await preferences.remove(key.toString());
//   }

//   getUserName() async {
//     final userName =  preferences.getString("userName");
//     return (userName);
//   }
//   getUserImage() async {
//     final userImage =  preferences.getString("userImage");
//     return (userImage);
//   }

//   setSideBarInfo(String userName, String userImage) async {
//     preferences.setString("userName", userName);
//     preferences.setString("userImage", userImage);
//   }
// }

// //   static void saveTheme(AppTheme selectedTheme) {
// //     if (null == selectedTheme) {
// //       selectedTheme = AppTheme.lightTheme;
// //     }
// //     String theme = jsonEncode(selectedTheme.toString());
// //     preferences.setString(KEY_SELECTED_THEME, theme);
// //   }

// //   static AppTheme getTheme() {
// //     String theme = preferences.getString(KEY_SELECTED_THEME);
// //     if (null == theme) {
// //       return AppTheme.lightTheme;
// //     }
// //     return getThemeFromString(jsonDecode(theme));
// //   }

// //   static AppTheme getThemeFromString(String theme) {
// //     for (AppTheme appTheme in AppTheme.values) {
// //       if (appTheme.toString() == theme) {
// //         return appTheme;
// //       }
// //     }
// //     return AppTheme.lightTheme;
// //   }
