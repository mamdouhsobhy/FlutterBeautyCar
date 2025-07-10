
import 'dart:convert';
import 'dart:ui';

import 'package:beauty_car/utils/Constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../authentication/data/response/login/login.dart';
import '../../resources/languageManager.dart';

const String PREFS_KEY_LANG = "PREFS_KEY_LANG";
const String PREFS_KEY_ONBOARDING_SCREEN_VIEWED = "PREFS_KEY_ONBOARDING_SCREEN_VIEWED";
const String PREFS_KEY_IS_USER_LOGGED_IN = "PREFS_KEY_IS_USER_LOGGED_IN";
const String PREFS_KEY_USER_DATA = "PREFS_KEY_USER_DATA";
const String PREFS_KEY_USER_TYPE = "PREFS_KEY_USER_TYPE";

class AppPreferences{
  final SharedPreferences _sharedPreferences;
  AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage() async{
    String? language = _sharedPreferences.getString(PREFS_KEY_LANG);
    if(language!=null && language == LanguageType.ENGLISH.getValue()){
      return LanguageType.ENGLISH.getValue();
    }else{
      return LanguageType.ARABIC.getValue();
    }
  }

  Future<void> changeAppLanguage(String lang) async{
    _sharedPreferences.setString(PREFS_KEY_LANG, lang);
  }

  Future<Locale> getLocale() async{
    String currentLang = await getAppLanguage();
    if(currentLang == LanguageType.ENGLISH.getValue()){
      return ENGLISH_LOCALE;
    }else{
      return ARABIC_LOCALE;
    }
  }

  Future<void> setOnBoardingScreenViewed() async{
    _sharedPreferences.setBool(PREFS_KEY_ONBOARDING_SCREEN_VIEWED, true);
  }

  Future<bool> isOnBoardingScreenViewed() async{
    return _sharedPreferences.getBool(PREFS_KEY_ONBOARDING_SCREEN_VIEWED)?? false;
  }

  Future<void> setUserLoggedIn(bool isLoggedIn) async {
    print("🟢 Checking isUserLoggedIn(): CALLED");
     _sharedPreferences.setBool(PREFS_KEY_IS_USER_LOGGED_IN, isLoggedIn);
  }

  Future<bool> isUserLoggedIn() async {
    bool isLoggedIn = _sharedPreferences.getBool(PREFS_KEY_IS_USER_LOGGED_IN) ?? false;
    print("🟢 Checking isUserLoggedIn(): $isLoggedIn");
    return isLoggedIn;
  }

  setUserType(int type) {
    _sharedPreferences.setInt(PREFS_KEY_USER_TYPE, type);
  }

  int getUserType() {
    int type = _sharedPreferences.getInt(PREFS_KEY_USER_TYPE) ?? 1;
    return type;
  }

  Future<void> setUserData(ModelLoginResponseRemote userData) async {
    // Convert userData to JSON
    String userJson = json.encode(userData.toJson());

    // Save to SharedPreferences
    await _sharedPreferences.setString(PREFS_KEY_USER_DATA, userJson);
  }

  Future<ModelLoginResponseRemote?> getUserData() async {
    String? userJson = _sharedPreferences.getString(PREFS_KEY_USER_DATA);
    if (userJson != null) {
      Map<String, dynamic> userMap = json.decode(userJson);
      return ModelLoginResponseRemote.fromJson(userMap);
    }
    return null;
  }

}