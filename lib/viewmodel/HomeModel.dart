import 'package:assignment/enums/viewstate.dart';
import 'package:assignment/model/search.dart';
import 'package:assignment/styleguide/strings.dart';
import 'package:assignment/util/locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../util/api.dart';
import 'BaseModel.dart';

class HomeModel extends BaseModel{
  Api _api = locator<Api>();
  String searchText = "";
  String searchTitle = "";
  String searchStr;
  SearchJSON result;
  Widget appBarTitle;
  Icon actionIcon;
  final TextEditingController searchQuery = new TextEditingController();




  changeSearchTitle(title){
    searchTitle=title;
    notifyListeners();
  }


  Future getSearchResult(searchStr)async{
    setState(ViewState.Busy);
    result = await _api.getSearchResult(searchStr);
    setState(ViewState.Idle);
  }

  void handleSearchEnd() {
    searchQuery.clear();
    notifyListeners();
  }



}