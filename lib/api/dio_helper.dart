// ignore_for_file: non_constant_identifier_names

import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as g;
import 'package:meals/api/api_endpoints.dart';

import '../model/single_meal.dart';

class DioHelpers extends g.GetxController {
  late Dio dio;

// Constructor
  DioHelpers() {
    dio = Dio(
      BaseOptions(),
    );
  }
   Future<Uint8List?> getBytesOfNetworkFile(String url) async {
    Response res;
    try {
      res = await dio.get(url);
      if (res.statusCode == 200) {
        return res.data;
      }
    } catch (err) {
      print("Error fetching network file for sharing");
      print(err);
      return null;
    }
    return null;
  }
  Future<Response?> categoriesGetAll() async {
    try {
      final res = await dio.get(ApiEndpoints.categoriesEndpoint);
      print(res);
      if (res.statusCode == 200) return res;
    } catch (err) {
      print(err);
      print('Error in MeetingsGetAll. <dioHelper>');
      if (err is DioError) {
        // print(err.requestOptions.uri);
        // print(err.requestOptions.headers);
        // print(err.requestOptions.queryParameters);
        if (err.response?.data is String) return err.response?.data;
      }
    }
  }

  Future categoryGetByName({required String strCategory}) async {
    try {
      final res = await dio
          .get("https://themealdb.com/api/json/v1/1/filter.php?c=$strCategory");

      if (res.statusCode == 200) {
        // print("https://themealdb.com/api/json/v1/1/filter.php?c=$strCategory");
        // print("get by name: ${res.data}");
        // print("Map: " + res.data is Map);
        return res;
      }
      // if (res.data is Map) {
      //   return Category.fromJson(Map<String, dynamic>.from(res.data));
      // }
    } catch (err) {
      print(err);
      print('Error in cdfDrillGetById. <dioHelper>');
    }
  }

  Future<MealSingle?> itemGetById({required String idMeal}) async {
    try {
      print(idMeal);
      final res = await dio.get(
        "https://themealdb.com/api/json/v1/1/lookup.php?i=$idMeal",
      );
      if (res.statusCode == 200) {
        // print("https://themealdb.com/api/json/v1/1/filter.php?c=$strCategory");
        // print("get by name: ${res.data}");
        // print("Map: " + res.data is Map);
        return MealSingle.fromJson(res.data["meals"][0]);
      }
      return null;
    } catch (err) {
      print(err);
      print('Error in cdfDrillGetById. <dioHelper>');
      // if (err is DioError) {
      //   print(err.requestOptions.headers);
      //   if (err.response?.data is String) return err.response!.data;
      // }
      return null;
    }
  }
}
