import 'package:flutter/material.dart';


class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dolphin Ride'),
        actions: <Widget>[
          FlatButton(child: Icon(Icons.exit_to_app),
          onPressed: ()=>{
            
          },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              color: Colors.red,
              child: Text('HOME'),
            ),
            FlatButton(
              color: Colors.yellow,
              child: Text('Logout'),
              onPressed: ()=>{

              },
            )
          ],
        )
      ),
    );
  }
}