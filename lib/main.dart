import 'package:dolphin_ride/provider_setup.dart';
import 'package:dolphin_ride/ui/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: 'DolphineRide',
        initialRoute: RoutePaths.Splash,
        onGenerateRoute: Router.generateRoute,
      ),
      
    );
  }
}

