import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static addStringToSF(String index, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(index, value);
  }

  static addIntToSF(String index, int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(index, value);
  }

  static addDoubleToSF(String index, double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble(index, value);
  }

  static addBoolToSF(String index, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(index, value);
  }

  static getStringValuesSF(String index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString(index);
    return stringValue;
  }

  static getBoolValuesSF(String index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return bool
    bool boolValue = prefs.getBool(index);
    return boolValue;
  }

  static getIntValuesSF(String index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return int
    int intValue = prefs.getInt(index);
    return intValue;
  }

  static getDoubleValuesSF(String index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return double
    double doubleValue = prefs.getDouble(index);
    return doubleValue;
  }

  static removeValues(String index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Remove String
    prefs.remove(index);
  }

  static checkValues(String index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(index);
  }
}
