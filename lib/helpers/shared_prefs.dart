import "package:shared_preferences/shared_preferences.dart";

class SharedPrefs{
	static Future<bool> hasKey(String key) async => (await SharedPreferences.getInstance()).containsKey(key);

	static Future<String> getString(String key) async => (await SharedPreferences.getInstance()).getString(key);

	static Future<int> getInt(String key) async => (await SharedPreferences.getInstance()).getInt(key);

	static Future<double> getDouble(String key) async => (await SharedPreferences.getInstance()).getDouble(key);

	static Future<List<String>> getList(String key) async => (await SharedPreferences.getInstance()).getStringList(key);

	static Future<bool> getBool(String key) async => (await SharedPreferences.getInstance()).getBool(key);

	static Future<bool> setString(String key, String value) async => (await SharedPreferences.getInstance()).setString(key, value);

	static Future<bool> setInt(String key, int value) async => await (await SharedPreferences.getInstance()).setInt(key, value);

	static Future<bool> setDouble(String key, double value) async => (await SharedPreferences.getInstance()).setDouble(key, value);

	static Future<bool> setList(String key, List<String> values) async => (await SharedPreferences.getInstance()).setStringList(key, values);

	static Future<bool> setBool(String key, bool value) async => (await SharedPreferences.getInstance()).setBool(key, value);
}


class Keys{
	static const String startDate = "StartDate";
}