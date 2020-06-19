import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:nourishnutrition/analytics.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  final MyAnalytics _myAnalytics = MyAnalytics(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nourish Nutrition',
      home: MyHomePage(
        title: 'Nourish Nutrition',
        myAnalytics: _myAnalytics,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({this.title, this.myAnalytics});

  final String title;
  final MyAnalytics myAnalytics;

  @override
  _MyHomePageState createState() {
    return _MyHomePageState(myAnalytics);
  }
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState(this.myAnalytics);

  final MyAnalytics myAnalytics;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: _buildBody(context, myAnalytics),
    );
  }

  Widget _buildBody(BuildContext context, MyAnalytics _myAnalytics) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('habits').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents, _myAnalytics);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot, MyAnalytics _myAnalytics) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data, _myAnalytics)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data, MyAnalytics _myAnalytics) {
    final record = Record.fromSnapshot(data);

    return Padding(
      key: ValueKey(record.name),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(record.name),
          trailing: Text(record.iconName),
          onTap: () {
            print(record);
            var thisName = record.name;
            _myAnalytics.sendAnalyticsEvent("tileTap", "User tapped tile $thisName");
          },
        ),
      ),
    );
  }
}

class Record {
  final String name;
  final String iconName;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['iconName'] != null),
        name = map['name'],
        iconName = map['iconName'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$name:$iconName>";
}