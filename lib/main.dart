// Required imports
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scoped_model/scoped_model.dart';
// Local Packages
import 'package:co_manager/pages/website_page.dart';
import 'package:co_manager/style/color_styles.dart';
import 'package:co_manager/objects/user.dart';
// Pages
import 'package:co_manager/pages/portal_page.dart';
import 'package:co_manager/pages/login_page.dart';
import 'package:co_manager/pages/createaccount_page.dart';

bool loginBypass = true;

// Main constructor
void main() => runApp(ManagerApp());

// App
class ManagerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: true,
        // Set up the app theme
        theme: ThemeData(
          accentColor: accentColor,
          primaryColor: primaryColor,
          brightness: Brightness.light,
        ),
        // Set up the app routes
        routes: {
          '/': (context) => SplashPage(),
          '/portal': (context) => Portal(),
          '/login': (context) => LoginPage(),
          '/signup': (context) => CreateAccountPage(),
          '/cafeEditor': (context) => CafePage(),
          '/notesEditor': (context) => NotesPage(),
        },
      ),
    );
  }
}

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _checkUserSignIn().then((value) {
      // Prompt user login if bypass is not enabled
      if (!loginBypass) {
        FirebaseAuth.instance.currentUser().then((currentUser) {
          if (currentUser == null) {
            // If current user is empty then push to login page
            Navigator.pushReplacementNamed(context, '/login');
          } else {
            // If user is not empty then fetch the data from the user
            Firestore.instance
                .collection('users')
                .document(currentUser.uid)
                .get()
                .then((result) {
              ScopedModel.of<UserModel>(context).setUserData(currentUser.uid,
                  result['name'], currentUser.email, result['permissions']);
              Navigator.pushReplacementNamed(context, '/portal');
            });
          }
        });
      } else {
        // Create a fake user on the app and forward to portal
        ScopedModel.of<UserModel>(context)
            .setUserData("00000", "LOGIN BYPASS", "music@music.com", ['admin']);
        Navigator.pushReplacementNamed(context, '/portal');
      }
    });

    return ScopedModelDescendant<UserModel>(
      builder: (context, child, model) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  // Delays the navigator from moving user until previous build is finished
  Future _checkUserSignIn() async {
    await Future.delayed(Duration(seconds: 2));
  }
}
