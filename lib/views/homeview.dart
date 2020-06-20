import 'dart:ui';

import 'package:assignment/enums/viewstate.dart';
import 'package:assignment/styleguide/colors.dart';
import 'package:assignment/styleguide/strings.dart';
import 'package:assignment/viewmodel/HomeModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'base_view.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double totalWidth = MediaQuery.of(context).size.width;
    double totalheight = MediaQuery.of(context).size.height;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: primaryDarkColor,
      //or set color with: Color(0xFF0000FF)
    ));

    return BaseView<HomeModel>(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          appBar: buildBar(context, model),
          backgroundColor: white,
          body: model.state == ViewState.Idle
              ? model.result != null && model.result.movies != null
                  ? Container(
                      padding: EdgeInsets.all(2.0),
                      child: GridView.count(
                        crossAxisCount: 2,
                        children:
                            List.generate(model.result.movies.length, (index) {
                          return Container(
                            margin: EdgeInsets.all(2.0),
                            padding: EdgeInsets.all(2.0),
                            color: black,
                            child: Stack(
                              children: [
                                CachedNetworkImage(
                                  placeholder: (context, url) => new Icon(
                                    null,
                                    color: Colors.grey,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      new Icon(
                                    null,
                                    color: Colors.grey,
                                  ),
                                  imageUrl:
                                      model.result.movies[index].Poster !=
                                              null
                                          ? model.result.movies[index].Poster
                                          : ConstantsString.blank,
                                  fit: BoxFit.fill,
                                  width: totalWidth,
                                ),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Container(
                                    height: 300.0,

                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [Colors.transparent, Colors.black])
                                    ),
                                    padding: EdgeInsets.all(10.0),
                                    //color: blackLight,
                                    width: totalWidth,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          model.result.movies[index].Title,
                                          style: GoogleFonts.rubik(
                                              fontSize: 17.0,
                                              fontWeight: FontWeight.w400,
                                              color: white),
                                        ),
                                        SizedBox(height: 5.0,),
                                        Text(
                                          model.result.movies[index].Year,
                                          style: GoogleFonts.rubik(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.w400,
                                              color: white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    )
                  : Center(child: Text(ConstantsString.movies_blank_text))
              : Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }

  Widget buildBar(BuildContext context, HomeModel model) {
    return new AppBar(
      backgroundColor: primaryColor,
        title: new TextField(
          onChanged: (s){
            if(s.length>1)
              model.getSearchResult(s.toString());
          },
          controller: model.searchQuery,
          style: new TextStyle(
            color: Colors.white,

          ),
          decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search, color: Colors.white),
              hintText: ConstantsString.searchtitle,
              hintStyle: new TextStyle(color: Colors.white)
          ),
        ),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.close, color: Colors.white),
            onPressed: () {
                model.handleSearchEnd();
            },
          ),
        ]);
  }
}
