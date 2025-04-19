import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class ProjectServices extends ChangeNotifier {
  User? currentUser = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveProject(String projectName, String description) async {
    try {
      CollectionReference projects = _firestore
          .collection('users')
          .doc(currentUser?.uid)
          .collection('projects');

      DocumentReference projectRef = await projects.add({
        'projectName': projectName,
        'description': description,
        'date': Timestamp.now(),
      });
      print(projectRef);
    } catch (e) {
      print('Failed to save data: $e');
    }
    notifyListeners();
  }

  Future<List<Map<String, dynamic>>> getProjectData() async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection("users")
          .doc(currentUser?.uid)
          .collection("projects")
          .get();

      List<Map<String, dynamic>> projectDataList = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      notifyListeners();
      return projectDataList;
    } catch (e) {
      print('Error loading data: $e');
      return [];
    }
  }

  Future<Map<String, dynamic>?> getLatestProject() async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection("users")
          .doc(currentUser?.uid)
          .collection("projects")
          .orderBy("date", descending: true)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.first.data() as Map<String, dynamic>;
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching latest project: $e');
      return null;
    }
  }
}
