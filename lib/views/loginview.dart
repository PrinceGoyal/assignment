import 'package:assignment/enums/viewstate.dart';
import 'package:assignment/model/login.dart';
import 'package:assignment/styleguide/colors.dart';
import 'package:assignment/styleguide/strings.dart';
import 'package:assignment/viewmodel/LoginModel.dart';
import 'package:assignment/views/homeview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'base_view.dart';

class LoginView extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginModel>(
      // onModelReady: (model) => model.getProductList(),
      builder: (context, model, child) => Scaffold(
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 80.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 10.0),
                    child: Center(
                      child: Text(
                        "Login".toUpperCase(),
                        style: GoogleFonts.rubik(
                          fontWeight: FontWeight.w800,
                          fontSize: 20.0,
                          color: black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  TextFormField(
                    autofocus: true,
                    style: GoogleFonts.rubik(fontSize: 16.0,color: black),
                    decoration: InputDecoration(labelText: ConstantsString.login_title_lable),
                    validator: (input) =>
                        input.isEmpty ? ConstantsString.login_error_title: null,
                    onSaved: (input) => model.username = input,
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    obscureText: true,
                    maxLength: 4,
                    style: GoogleFonts.rubik(fontSize: 16.0,color: black),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration( counterText: "",labelText: ConstantsString.login_year_lable),
                    validator: (input) =>
                        input.length < 4 ? ConstantsString.login_error_year : null,
                    onSaved: (input) => model.password = input,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FlatButton(
                          onPressed: () {
                            if (formKey.currentState.validate()) {
                              formKey.currentState.save();
                              model.loginResult().then((value) => {
                                    if (value.Error.isEmpty)
                                      {
                                        Navigator.of(context).pushReplacement(
                                            _createRoute())
                                      }
                                    else
                                      {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                Dialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  elevation: 0.0,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  child: _ErrorDialogContent(
                                                      context, value.Error),
                                                ))
                                      }
                                  });
                              formKey.currentState.reset();
                            }
                          },
                          child: model.state == ViewState.Idle
                              ? Container(
                                  margin: EdgeInsets.only(left: 50),
                                  padding: EdgeInsets.all(1),
                                  height: 36.0,
                                  width: 80.0,
                                  decoration: ShapeDecoration(
                                      color: primaryDarkColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: new BorderRadius.all(
                                          Radius.circular(2.0),
                                        ),
                                      )),
                                  child: Container(
                                    decoration: ShapeDecoration(
                                        color: primaryDarkColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: new BorderRadius.all(
                                            Radius.circular(2.0),
                                          ),
                                        )),
                                    child: Center(
                                        child: Text(
                                      ConstantsString.submit,
                                      style: GoogleFonts.rubik(
                                          fontSize: 14,
                                          color: white,
                                          fontWeight: FontWeight.w500),
                                    )),
                                  ),
                                )
                              : Center(child: CircularProgressIndicator()),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => HomeView(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {

        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    );
  }


  _ErrorDialogContent(BuildContext context, String error) {
    return Container(
      decoration: new BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: const Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Container(
        padding: EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              error,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Exo',
                fontWeight: FontWeight.w500,
                color: black,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 40.0),
                    padding: EdgeInsets.all(1.0),
                    decoration: ShapeDecoration(
                        color: blue,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              new BorderRadius.all(Radius.circular(2.0)),
                        )),
                    child: Container(
                      height: 29.0,
                      width: 69.0,
                      decoration: ShapeDecoration(
                          color: white,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                new BorderRadius.all(Radius.circular(2.0)),
                          )),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 2.0),
                              child: Text(
                                "Close",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
