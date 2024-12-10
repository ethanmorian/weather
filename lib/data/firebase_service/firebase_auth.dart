import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram/data/firebase_service/firestore_user_manager.dart';
import 'package:instagram/data/firebase_service/storage.dart';
import 'package:instagram/util/exception.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
    } on FirebaseException catch (e) {
      throw Exceptions(e.message.toString());
    }
  }

  Future<void> signup({
    required String email,
    required String password,
    required String passwordConfirm,
    required String username,
    required String bio,
    required File profile,
  }) async {
    String url;
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          username.isNotEmpty &&
          bio.isNotEmpty) {
        if (password == passwordConfirm) {
          await _auth.createUserWithEmailAndPassword(
            email: email.trim(),
            password: password.trim(),
          );

          if (profile.path.isNotEmpty && profile.existsSync()) {
            url = await StorageMethod().uploadImageToStorage(
              'Profile',
              profile,
            );
          } else {
            url = '';
          }

          await FirestoreUserManager().createUser(
            email: email,
            username: username,
            bio: bio,
            profile: url == ''
                ? 'https://firebasestorage.googleapis.com/v0/b/instagram-8a227.appspot.com/o/person.png?alt=media&token=c6fcbe9d-f502-4aa1-8b4b-ec37339e78ab'
                : url,
          );
        } else {
          throw Exceptions('password and confirm password should be same');
        }
      } else {
        throw Exceptions('enter all the fields');
      }
    } on FirebaseException catch (e) {
      throw Exceptions(e.message.toString());
    }
  }
}
