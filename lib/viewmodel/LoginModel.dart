
import 'package:assignment/enums/viewstate.dart';
import 'package:assignment/model/login.dart';
import 'package:assignment/util/api.dart';
import 'package:assignment/util/locator.dart';
import 'BaseModel.dart';

class LoginModel extends BaseModel{
  Api _api = locator<Api>();

  String username, password;


Future<Login> loginResult()async{
  setState(ViewState.Busy);
  Login loginResult= await _api.getLoginResult(username, password);
  setState(ViewState.Idle);
  return loginResult;
}


}