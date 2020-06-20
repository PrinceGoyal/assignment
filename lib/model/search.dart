
class SearchJSON{

  List<Movies> movies;
  String _Error;

  SearchJSON(this._Error);


  String get Error => _Error;

  SearchJSON.fromJson(Map<String, dynamic> json) {
    movies = parseMovies(json);
  }

  List<Movies> parseMovies(json){
    _Error= json['Error'].toString()?? "";
    var list= json['Search'] as List;
    List<Movies>movieList=list.map((e) => Movies.fromJson(e)).toList();
    return movieList;
  }


}
class Movies{
  String _Title;
  String _Year;
  String _imdbID;
  String _Poster;

  Movies.fromJson(Map<String, dynamic> json) {
    _Title = json['Title'].toString();
    _Year = json['Year'].toString();
    _imdbID = json['imdbID'].toString();
    _Poster = json['Poster'].toString();
  }

  String get Poster => _Poster;

  String get imdbID => _imdbID;

  String get Year => _Year;

  String get Title => _Title;


}