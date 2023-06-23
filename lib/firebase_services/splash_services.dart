import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter/ui/posts/post_screen.dart';
import 'package:flutter/material.dart';

import '../ui/auth/login_screen.dart';

class SplashServices {

  void isLogin(BuildContext context) {
   final _auth = FirebaseAuth.instance;

   final user = _auth.currentUser;

   if(user != null){
     Timer(Duration(seconds: 3), () =>
         Navigator.push(context,
             MaterialPageRoute(builder: (context) => const PostScreen()))
     );
   }else{
     Timer(Duration(seconds: 3), () =>
         Navigator.push(context,
             MaterialPageRoute(builder: (context) => const LoginScreen()))
     );
   }
  }
}