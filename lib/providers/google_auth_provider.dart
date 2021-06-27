import 'package:flutter/material.dart';

//packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  late bool _isSigningIn;

  GoogleSignInProvider() {
    _isSigningIn = false;
  }

  // get signIn bool
  bool get isSigningIn => _isSigningIn;
  set isSigningIn(bool isSigningIn) {
    _isSigningIn = isSigningIn;
    notifyListeners();
  }

  // function for google login
  Future googleLogIn() async {
    isSigningIn = true;
    final user = await googleSignIn.signIn();

    if (user == null) {
      isSigningIn = false;
      return;
    } else {
      isSigningIn = true;
      final googleAuth = await user.authentication;

      // getting the credentials for google sign in
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      // signing in with credentials
      await FirebaseAuth.instance.signInWithCredential(credential);

      // adding data to Firestore
      await addDataToFireStore();
      isSigningIn = false;
    }
    print('G-Login Approved');
    notifyListeners();
  }

  // function to logout the loggedUser
  void googleLogout() async {
    isSigningIn = true;
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
    isSigningIn = false;
    print('Logged Out');
  }

  // function to add data to firestore to users
  Future<void> addDataToFireStore() async {
    var currUser = FirebaseAuth.instance.currentUser;

    // will check if currUser is present in my users Collection
    final result = await FirebaseFirestore.instance
        .collection('users')
        .doc(currUser!.uid)
        .get();

    // Add Data Only For SignUp Activity
    if (result.data() == null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currUser.uid)
          .set({
        'userId': currUser.uid,
        'email': currUser.email,
        'name': currUser.displayName,
        'imageUrl': currUser.photoURL,
      });

      print('Signed Up');
    }
  }
}
