import 'package:dolphin_ride/core/viewmodels/signup/auth_view_model.dart';
import 'package:dolphin_ride/ui/router.dart';
import 'package:dolphin_ride/ui/views/base_view.dart';
import 'package:dolphin_ride/ui/views/signup/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
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
        model.getUser().then((snapshot){
          if (snapshot == null){
            Navigator.pushReplacementNamed(context, RoutePaths.Login);
          } else {
            Navigator.pushReplacementNamed(context, RoutePaths.Home);
          }
        });
      },
      onViewFirstLoad: (BuildContext context, AuthViewModel model) {
        print("View is rendered");
      },
      builder: (context, model) {
        return Scaffold(
        body: Center(
          child: Container(
            child: Text("Loading..."),
          ),
        ),
      );
      }
      
    );
  }
}