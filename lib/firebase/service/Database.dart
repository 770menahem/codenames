import 'package:cloud_firestore/cloud_firestore.dart';

class DatabadeService {
  final String uid;
  DatabadeService(this.uid);

  final CollectionReference collection =
      FirebaseFirestore.instance.collection('codename');
}
