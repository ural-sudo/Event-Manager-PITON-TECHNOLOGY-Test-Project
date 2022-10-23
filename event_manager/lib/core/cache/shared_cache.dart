
import 'package:shared_preferences/shared_preferences.dart';

class SharedManager {

  Future<void> savePref(String key,String value) async {
    final SharedPreferences sharedPref = await  SharedPreferences.getInstance();
    await sharedPref.setString(key, value);
  }

  Future<String> getPref(String key) async {
    final SharedPreferences sharedPref  = await SharedPreferences.getInstance();
    final recoredPref = sharedPref.getString(key);
    if(recoredPref != null){

      return recoredPref;
    }else{
      return "";
    }
  }

  Future<bool> removePref(String key) async {
    final SharedPreferences sharedPref = await SharedPreferences.getInstance();
    final result =  await sharedPref.remove(key);
    return result;
  }


}