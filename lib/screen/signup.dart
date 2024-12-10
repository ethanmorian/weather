import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram/data/firebase_service/firebase_auth.dart';
import 'package:instagram/util/dialog.dart';
import 'package:instagram/util/exception.dart';
import 'package:instagram/util/imagepicker.dart';

class Signup extends StatefulWidget {
  final VoidCallback show;

  const Signup(this.show, {super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final email = TextEditingController();
  FocusNode emailFocus = FocusNode();
  final username = TextEditingController();
  FocusNode usernameFocus = FocusNode();
  final bio = TextEditingController();
  FocusNode bioFocus = FocusNode();
  final password = TextEditingController();
  FocusNode passwordFocus = FocusNode();
  final passwordConfirm = TextEditingController();
  FocusNode passwordConfirmFocus = FocusNode();

  File? _imageFile;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    email.dispose();
    username.dispose();
    bio.dispose();
    password.dispose();
    passwordConfirm.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              children: [
                SizedBox(
                  width: 96.w,
                  height: 30.h,
                ),
                Center(
                  child: Image.asset('assets/logo.jpg'),
                ),
                SizedBox(height: 60.h),
                InkWell(
                  onTap: () async {
                    File galleryImageFile =
                        await CustomImagePicker().uploadImage('gallery');
                    setState(() {
                      _imageFile = galleryImageFile;
                    });
                  },
                  child: CircleAvatar(
                    radius: 36.r,
                    backgroundColor: Colors.grey,
                    child: _imageFile == null
                        ? CircleAvatar(
                            radius: 34.r,
                            backgroundImage:
                                const AssetImage('assets/person.png'),
                            backgroundColor: Colors.grey.shade200,
                          )
                        : CircleAvatar(
                            radius: 34.r,
                            backgroundImage: Image.file(
                              _imageFile!,
                              fit: BoxFit.cover,
                            ).image,
                            backgroundColor: Colors.grey.shade200,
                          ),
                  ),
                ),
                SizedBox(height: 50.h),
                textField(
                  email,
                  Icons.email,
                  'Email',
                  emailFocus,
                ),
                SizedBox(height: 15.h),
                textField(
                  username,
                  Icons.person,
                  'Username',
                  usernameFocus,
                ),
                SizedBox(height: 15.h),
                textField(
                  bio,
                  Icons.abc,
                  'bio',
                  bioFocus,
                ),
                SizedBox(height: 15.h),
                textField(
                  password,
                  Icons.lock,
                  'Password',
                  passwordFocus,
                ),
                SizedBox(height: 15.h),
                textField(
                  passwordConfirm,
                  Icons.lock,
                  'PasswordConfirm',
                  passwordConfirmFocus,
                ),
                SizedBox(height: 20.h),
                signup(),
                SizedBox(height: 10.h),
                have()
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget have() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Don't have account?  ",
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.grey,
            ),
          ),
          GestureDetector(
            onTap: widget.show,
            child: Text(
              'Login ',
              style: TextStyle(
                fontSize: 15.sp,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget signup() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: InkWell(
        onTap: () async {
          try {
            await Authentication().signup(
              email: email.text,
              password: password.text,
              passwordConfirm: passwordConfirm.text,
              username: username.text,
              bio: bio.text,
              profile: _imageFile ?? File(''),
            );
          } on Exceptions catch (e) {
            dialogBuilder(
              context,
              e.message,
            );
          }
        },
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 44.h,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Text(
            'Sign up',
            style: TextStyle(
              fontSize: 23.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget textField(
    TextEditingController controller,
    IconData icon,
    String type,
    FocusNode focusNode,
  ) {
    return Container(
      height: 44.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: TextField(
          style: TextStyle(
            fontSize: 18.sp,
            color: Colors.black,
          ),
          controller: controller,
          focusNode: focusNode,
          decoration: InputDecoration(
            hintText: type,
            prefixIcon: Icon(
              icon,
              color: focusNode.hasFocus ? Colors.black : Colors.grey,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 15.h,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.r),
              borderSide: BorderSide(
                color: Colors.grey,
                width: 2.w,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.r),
              borderSide: BorderSide(
                color: Colors.black,
                width: 2.w,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
