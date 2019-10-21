import 'package:dolphin_ride/core/viewmodels/signup/auth_view_model.dart';
import 'package:dolphin_ride/ui/router.dart';
import 'package:dolphin_ride/ui/views/base_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginView extends StatefulWidget {
  LoginView({Key key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  TextEditingController emailInputController;
  TextEditingController pwdInputController;

  @override
  initState() {
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();
    super.initState();
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  String pwdValidator(String value) {
    if (value.length < 6) {
      return 'Password must be longer than 6 characters';
    } else {
      return null;
    }
  }

  Future _buildErrorDialog(BuildContext context, _message) {
    return showDialog(
      builder: (context) {
        return AlertDialog(
          title: Text('Error Message'),
          content: Text(_message),
          actions: <Widget>[
            FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ],
        );
      },
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<AuthViewModel>(
      model: AuthViewModel(),
      onErrorOccured: (BuildContext context, AuthViewModel model, String errorCode) {
        print("Got a new error: $errorCode");
      },
      onEventOccured: (BuildContext context, AuthViewModel model, String event) {
        print("Got a new event: $event");
      },
      onModelReady: (AuthViewModel model) {
        print("Model is ready, but view is still not visible");
        
      },
      onViewFirstLoad: (BuildContext context, AuthViewModel model) {
        print("View is rendered");
      },
          builder: (context, model) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Login"),
          ),
          body: Container(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                  child: Form(
                key: _loginFormKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Email*', hintText: "test@gmail.com"),
                      controller: emailInputController,
                      keyboardType: TextInputType.emailAddress,
                      validator: emailValidator,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Password*', hintText: "********"),
                      controller: pwdInputController,
                      obscureText: true,
                      validator: pwdValidator,
                    ),
                    RaisedButton(
                      child: Text("Login"),
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      onPressed: () async {
                        if (_loginFormKey.currentState.validate()) {
                          try {
                            FirebaseUser user = await model.loginUser(email: emailInputController.text, password: pwdInputController.text);
                            if (user != null){
                              Navigator.pushReplacementNamed(context, RoutePaths.Home);
                            }
                          } on AuthException catch (error){
                            return _buildErrorDialog(context, error.message);
                          }on Exception catch (error) {
                            return _buildErrorDialog(context, error.toString());
                          }
                        }
                      },
                    ),
                  ],
                ),
              ))));
          });
  }
}