

class Login{
  String _Error,_Title,_Year;

  Login(this._Error);


  Login.fromJson(Map<String, dynamic> json) {
    _Error = json['Error'].toString().replaceAll("null", "")?? "";
    _Title = json['Title'].toString()?? "";
    _Year = json['Year'].toString()?? "";
  }

  get Year => _Year;

  get Title => _Title;

  String get Error => _Error;


}