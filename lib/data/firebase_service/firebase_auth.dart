import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram/auth/storage.dart';
import 'package:instagram/util/exception.dart';

class Authentication {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> Signup({
    required String email,
    required String password,
    required String passwordConfirm,
    required String username,
    required String bio,
    required File profile,
  }) async {
    String URL;
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

          if (profile != File('')) {
            URL = await StorageMethod().uploadImageToStorage(
              'Profile',
              profile,
            );
          } else {
            URL = '';
          }
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
