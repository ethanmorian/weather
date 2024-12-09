import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram/data/firebase_service/firebase_auth.dart';

class Login extends StatefulWidget {
  final VoidCallback show;

  const Login(this.show, {super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final email = TextEditingController();
  FocusNode emailFocus = FocusNode();
  final password = TextEditingController();
  FocusNode passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              width: 96.w,
              height: 100.h,
            ),
            Center(
              child: Image.asset('assets/logo.jpg'),
            ),
            SizedBox(height: 120.h),
            textField(
              email,
              Icons.email,
              'Email',
              emailFocus,
            ),
            SizedBox(height: 15.h),
            textField(
              password,
              Icons.lock,
              'Password',
              passwordFocus,
            ),
            SizedBox(height: 10.h),
            forget(),
            SizedBox(height: 10.h),
            login(),
            SizedBox(height: 10.h),
            have()
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
              'Sign up ',
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

  Widget login() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: InkWell(
        onTap: () {
          Authentication().login(
            email: email.text,
            password: password.text,
          );
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
            'Log in',
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

  Widget forget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Text(
        'Forget your password?',
        style: TextStyle(
          fontSize: 13.sp,
          color: Colors.blue,
          fontWeight: FontWeight.bold,
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
