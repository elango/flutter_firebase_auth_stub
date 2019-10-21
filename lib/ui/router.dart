import 'package:dolphin_ride/ui/views/screens/home_view.dart';
import 'package:dolphin_ride/ui/views/signup/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import './views/splash_view.dart';

class RoutePaths {
  static const String Login = 'login';
  static const String Home = '/';
  static const String Post = 'post';
  static const String Splash = 'splash';
}

class Router{
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch (settings.name) {
      case RoutePaths.Home:
        return MaterialPageRoute(builder: (_) => HomeView());
        break;
      case RoutePaths.Login:
        return MaterialPageRoute(builder: (_) => LoginView());
      break;
      case RoutePaths.Splash:
        return MaterialPageRoute(builder: (_) => SplashView());
      break;
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}