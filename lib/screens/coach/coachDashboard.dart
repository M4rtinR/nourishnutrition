import 'package:flutter/material.dart';
import 'package:easy_firebase_auth/easy_firebase_auth.dart';
import 'package:provider/provider.dart';

class CoachDashboard extends StatefulWidget {
  CoachDashboard({this.title});

  final String title;

  @override
  _CoachDashboardState createState(){
    return(_CoachDashboardState());
  }
}

class _CoachDashboardState extends State<CoachDashboard>{

  AuthState authState = AuthState();

  @override
  Widget build(BuildContext context){
    AuthState authState = Provider.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      backgroundColor: Colors.blue,
      body: Center(
        child: RaisedButton(
          onPressed: () {
            authState.signOut();
          },
          child: Text(authState.email),
        ),
      ),
    );
  }
}