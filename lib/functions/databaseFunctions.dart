import 'package:cloud_firestore/cloud_firestore.dart';

class UserRecord {
  final String forename;
  final String surname;
  final String email;
  final int height;
  final int weight;
  final assignedHabits;
  final DocumentReference reference;

  UserRecord.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['forename'] != null),
        assert(map['surname'] != null),
        assert(map['email'] != null),
        assert(map['height'] != null),
        assert(map['weight'] != null),
        assert(map['assigned-habits'] != null),
        forename = map['forename'],
        surname = map['surname'],
        email = map['email'],
        height = map['height'],
        weight = map['weight'],
        assignedHabits = map['assigned-habits'];

  UserRecord.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "UserRecord<$forename $surname>";
}

class HabitRecord {
  final String name;
  final String iconName;
  final String description;
  final DocumentReference reference;

  HabitRecord.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['iconName'] != null),
        assert(map['description'] != null),
        name = map['name'],
        iconName = map['iconName'],
        description = map['description'];

  HabitRecord.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "HabitRecord<$name>";
}

class UserHabitRecord {
  final String name;
  final String description;
  final int times;
  final String per;
  final String iconName;
  final DocumentReference reference;

  UserHabitRecord.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['description'] != null),
        assert(map['times'] != null),
        assert(map['per'] != null),
        assert(map['icon-name'] != null),
        name = reference.documentID,
        description = map['description'],
        times = map['times'],
        per = map['per'],
        iconName = map['icon-name'];

  UserHabitRecord.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "UserHabitRecord<$name: $description>";
}

class HabitCompletionRecord {
  final String date;
  final int timesCompleted;
  final DocumentReference reference;

  HabitCompletionRecord.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['times-completed'] != null),
        date = reference.documentID,
        timesCompleted = map['times-completed'];

  HabitCompletionRecord.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "HabitAssignmentRecord<$date: $timesCompleted>";
}