import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';


/// 存储工具类
class StorageUtil {
  static late SharedPreferences sharedPreferences;

  /// 初始化存储
  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  /// 写入字符串、传入两个参数：key 和 value
  static Future<bool> setString(String key, String value)  {
    return  sharedPreferences.setString(key, value);
  }

  /// 获取字符串、只需要传入键，可设置默认值
  static String getString(String key,{String defaultValue = ''}){
    return sharedPreferences.getString(key) ?? defaultValue;
  }

  /// 写入布尔值
  static Future<bool> setBool(String key, bool value)  {
    return sharedPreferences.setBool(key, value);
  }

  /// 获取布尔值
  static bool getBool(String key,{bool defaultValue = false}){
    return sharedPreferences.getBool(key) ?? defaultValue;
  }

  /// 写入浮点数
  static Future<bool> setDouble(String key, double value)  {
    return sharedPreferences.setDouble(key, value);
  }

  /// 获取浮点数
  static double getDouble(String key,{double defaultValue = 0.0}){
    return sharedPreferences.getDouble(key) ?? defaultValue;
  }

  /// 写入整数
  static Future<bool> setInt(String key, int value)  {
    return sharedPreferences.setInt(key, value);
  }

  /// 获取整数
  static int getInt(String key,{int defaultValue = 0}){
    return sharedPreferences.getInt(key) ?? defaultValue;
  }

  /// 获取对象
  static Map<String,dynamic> getObject(String key){
    String? jsonString = sharedPreferences.getString(key);
    if( jsonString != null) {
      return json.decode(jsonString);
    }

    return {};
  }

  /// 存储对象
  static Future<bool> setObject(String key, Map<String,dynamic> value) async {
    return setString(key, json.encode(value));
  }

  /// 获取列表对象
  static List<dynamic> getList(String key){
    String? jsonString = sharedPreferences.getString(key);
    if( jsonString != null) {
      return json.decode(jsonString) as List<dynamic>;
    }

    return [];
  }

  /// 存储列表对象
  static Future<bool> setList(String key, List<dynamic> value) async {
    return setString(key, json.encode(value));
  }

  /// 删除存储的数据
  static Future<bool> delete(String key) {
    return sharedPreferences.remove(key);
  }

  /// 清空所有数据
  static Future<bool> clear() {
    return sharedPreferences.clear();
  }
}