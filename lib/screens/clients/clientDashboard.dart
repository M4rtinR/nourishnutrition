import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_firebase_auth/easy_firebase_auth.dart';
import 'package:nourishnutrition/functions/databaseFunctions.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClientDashboard extends StatefulWidget {
  ClientDashboard({this.title});

  final String title;

  @override
  _ClientDashboardState createState(){
    return(_ClientDashboardState());
  }
}

class _ClientDashboardState extends State<ClientDashboard>{

  AuthState authState = AuthState();

  @override
  Widget build(BuildContext context){


    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      backgroundColor: Colors.white,
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    AuthState authState = Provider.of(context);

    final userID = authState.uid;
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('users').document(userID).collection('habits').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final habit = UserHabitRecord.fromSnapshot(data);

    bool completed = true;

    return Padding(
      key: ValueKey(habit.name),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: completed ? Border.all(color: Colors.green) : Border.all(color: Colors.grey),
          //borderRadius: completed ? BorderRadius.circular(10.0) : BorderRadius.circular(5.0),
          shape: BoxShape.circle,
        ),
        child: ListTile(
          title: Text(habit.name),
          trailing: Text(habit.iconName),
          onTap: () {
            print(habit);
          },
        ),
      ),
    );
  }
}