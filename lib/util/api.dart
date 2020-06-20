import 'dart:convert';
import 'dart:io';

import 'package:assignment/model/login.dart';
import 'package:assignment/model/search.dart';
import 'package:assignment/styleguide/strings.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../error_handling/AppExceptions.dart';

class Api {
  static const endpoint = ConstantsString.apiWithKey;

  var client = new http.Client();

  Future<Login> getLoginResult(title, year) async {
    try {
      Response res = await get(endpoint + "&t=" + title + "&y=" + year);
      if (res.statusCode == 200) {
        final body = jsonDecode(res.body);
        Login result = Login.fromJson(body);
        return result;
      } else {
        return new Login(ConstantsString.no_internet);
      }
    } catch (e) {
      return new Login(e.toString());
    }
  }

  Future<SearchJSON> getSearchResult(searchStr) async {
    try {
      Response res = await get(endpoint + "&s=" + searchStr);
      if (res.statusCode == 200) {
        final body = jsonDecode(res.body);
        SearchJSON search = SearchJSON.fromJson(body);
        return search;
      } else {
        return new SearchJSON(ConstantsString.no_internet);
      }
    } catch (e) {
      return new SearchJSON(e.toString());
    }
  }
}
