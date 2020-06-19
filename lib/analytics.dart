import 'dart:async';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class MyAnalytics{
  MyAnalytics({this.analytics});

  final FirebaseAnalytics analytics;

  Future<void> sendAppOpenEvent() async {
    await analytics.logAppOpen();
  }

  Future<void> sendAnalyticsEvent(String eventName, String message) async {
    await analytics.logEvent(
      name: eventName,
      parameters: <String, dynamic>{
        'string': message,
      },
    );
  }
}
