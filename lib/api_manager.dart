
import 'dart:convert';

import 'package:card_movies/models/api_constant.dart';
import 'package:card_movies/models/general_list_response.dart';
import 'package:card_movies/models/movies_response.dart';
import 'package:http/http.dart' as http;

class ApiManager {
  static Future<MoviesModel?> getPopularMovies() async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': ApiConstant.tokenAuth,
    };
    Uri url = Uri.https(ApiConstant.baseUrl, ApiConstant.popularApi, {});
    try {
      var response = await http.get(url, headers: requestHeaders);
      // var responseBody = response.body;
      var json = jsonDecode(response.body);
      return MoviesModel.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  static Future<MoviesModel?> getNewReleasesMovies() async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': ApiConstant.tokenAuth,
    };
    Uri url = Uri.https(ApiConstant.baseUrl, ApiConstant.upCommingApi, {});
    try {
      var response = await http.get(url, headers: requestHeaders);
      // var responseBody = response.body;
      var json = jsonDecode(response.body);
      return MoviesModel.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  static Future<MoviesModel?> getTopRatedMovies() async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': ApiConstant.tokenAuth,
    };
    Uri url = Uri.https(ApiConstant.baseUrl, ApiConstant.recomendedApi, {});
    try {
      var response = await http.get(url, headers: requestHeaders);
      // var responseBody = response.body;
      var json = jsonDecode(response.body);
      return MoviesModel.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  static Future<MoviesModel?> getCategoryMoviesList(int? categoryId) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': ApiConstant.tokenAuth,
    };
    try {
      var response = await http.get(
          Uri.parse(
              '${ApiConstant.baseUrl2}/3/discover/movie?language=en-US&sort_by=popularity.desc&include_adult='
                  'false&include_video=false&page=1&with_genres=$categoryId&with_watch_monetization_types=flatrate'),
          headers: requestHeaders);
      // var responseBody = response.body;
      var json = jsonDecode(response.body);
      return MoviesModel.fromJson(json);
    } catch (e) {
      print("Error: $e");

      throw e;
    }

  }

  static Future<GeneralCategoryList?> getGeneralCategoryList() async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': ApiConstant.tokenAuth,
    };
    Uri url = Uri.https(ApiConstant.baseUrl, ApiConstant.moviesListApi, {
      // 'with_genres':categotyId
    });
    try {
      var response = await http.get(url, headers: requestHeaders);
      // var responseBody = response.body;
      var json = jsonDecode(response.body);
      return GeneralCategoryList.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  static Future<MoviesModel> getSearchMovies(String? query) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': ApiConstant.tokenAuth,
    };
    Uri url =
    Uri.https(ApiConstant.baseUrl, ApiConstant.searchApi, {'query': query});
    try {
      var response = await http.get(url, headers: requestHeaders);
      // var responseBody = response.body;
      var json = jsonDecode(response.body);
      return MoviesModel.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  static Future<MoviesModel> getSimilarMovies(num? movieId) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': ApiConstant.tokenAuth,
    };
    Uri url = Uri.https(ApiConstant.baseUrl, "/3/movie/$movieId/similar", {});
    try {
      var response = await http.get(url, headers: requestHeaders);
      // var responseBody = response.body;
      var json = jsonDecode(response.body);
      return MoviesModel.fromJson(json);
    } catch (e) {
      throw e;
    }
  }
}
