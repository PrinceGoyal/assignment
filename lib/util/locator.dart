
import 'package:assignment/viewmodel/HomeModel.dart';
import 'package:assignment/viewmodel/LoginModel.dart';
import 'package:get_it/get_it.dart';

import 'api.dart';

GetIt locator =  GetIt.instance;


void setupLocator(){
  locator.registerLazySingleton(() => Api());
  locator.registerLazySingleton(() => HomeModel());
  locator.registerLazySingleton(() => LoginModel());

}


