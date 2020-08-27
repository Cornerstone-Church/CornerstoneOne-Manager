import 'package:flutter/material.dart';

// Firebase
import 'package:firebase_auth/firebase_auth.dart';

// Custom Widget
import '../widgets/cag_button.dart';
import '../widgets/cag_text_form.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Login form key
  final _formKey = GlobalKey<FormState>();

  // Stores what user enters
  String _email, _password;

  // Error message string
  String errorMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        // Window border
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: DecoratedBox(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).primaryColor, width: 6.0)),
              )),
        ),
        // Content
        Center(
          child: Container(
            constraints: BoxConstraints(minWidth: 300, maxWidth: 500),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // Logo
                Hero(
                  tag: 'titleHero',
                  child: Text(
                    'CORNERSTONE ONE',
                    style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                  ),
                ),
                // Login form
                loginForm(context),
              ],
            ),
          ),
        )
      ]),
    );
  }

  Widget loginForm(context) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            // Email textbox
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: CTextInput(
                    label: 'Email',
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter email';
                      } else {
                        _email = value;
                        return null;
                      }
                    },
                    isPassword: false)),
            // Password textbox
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CTextInput(
                  label: 'Password',
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter password';
                    } else {
                      _password = value;
                      return null;
                    }
                  },
                  isPassword: true),
            ),
            // Error message if login not succesful
            Text(
              errorMessage,
              style: TextStyle(color: Colors.red),
            ),
            // Login button
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              child: CButton(
                  text: 'Login',
                  onPressedAction: () {
                    submitForm();
                  }),
            )
          ],
        ),
      ),
    );
  }

  submitForm() {
    if (_formKey.currentState.validate()) {
      // Sign in Action
      signIn(_email, _password).then((value) {
        if (value) {
          Navigator.pushReplacementNamed(context, '/');
        } else {
          setState(() {
            errorMessage = "Wrong username or password";
          });
        }
      });
    }
  }

  /// Sign user into app
  /// This function will return TRUE or FALSE depending on if login was succesful or not.
  Future<bool> signIn(String email, String password) async {
    bool result;
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      result = true;
    }).catchError((e) {
      result = false;
    });
    return result;
  }
}
