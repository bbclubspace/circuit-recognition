import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class CreateAccountProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  User? _user;
  Map<String, dynamic>? _userData;
  Map<String, dynamic>? get userData => _userData;
  User? get user => _user;
  Future<User?> signUpWithEmail({
    required String name,
    required String surname,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'name': name,
          'surname': surname,
          'email': email,
        });
        notifyListeners();
        return user;
      }
    } on FirebaseAuthException catch (e) {
      print("Firebase Hatası: ${e.message}");
    } catch (e) {
      print("Bilinmeyen Hata: $e");
    }
    return null;
  }

  Future<User?> signInWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      notifyListeners();
      return userCredential.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<User?> signInWithGoogle(BuildContext context) async {
  try {
    final GoogleSignInAccount? gUser = await _googleSignIn.signIn();
    if (gUser == null) return null;

    final GoogleSignInAuthentication gAuth = await gUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    UserCredential userCredential =
        await _auth.signInWithCredential(credential);

    _user = userCredential.user;

    if (_user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(_user!.uid)
          .get();

      if (!userDoc.exists) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(_user!.uid)
            .set({
          'email': _user!.email,
          'name': _user!.displayName,
          'surname': _user!.displayName != null &&
                  _user!.displayName!.split(' ').length > 1
              ? _user!.displayName!.split(' ').sublist(1).join(' ')
              : '',
        });
      }
    }

    notifyListeners();
    return _user;
  } catch (e) {
    print("Google Sign-In failed: ${e.toString()}");
    return null;
  }
}


  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    _user = null;
    notifyListeners();
  }

  Future<Map<String, dynamic>?> fetchUserData() async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser != null) {
        DocumentSnapshot doc =
            await _firestore.collection('users').doc(currentUser.uid).get();
        if (doc.exists) {
          return doc.data() as Map<String, dynamic>;
        }
      }
    } catch (e) {
      print("Kullanıcı verileri alınırken hata oluştu: $e");
    }
    return null;
  }

  Future<void> loadUserData() async {
    _userData = await fetchUserData();
    notifyListeners();
  }
}
