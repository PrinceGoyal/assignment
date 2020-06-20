import 'package:assignment/enums/viewstate.dart';
import 'package:flutter/cupertino.dart';

class BaseModel extends ChangeNotifier{

  ViewState _state=ViewState.Idle;

  ViewState get state => _state;

  void setState(ViewState value) {
    _state = value;
    notifyListeners();
  }


}