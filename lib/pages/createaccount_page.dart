import 'package:flutter/material.dart';

// Firebase Auth
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Widgets
import '../widgets/cag_text_form.dart';
import '../widgets/cag_button.dart';

class CreateAccountPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CreateAccountState();
  }
}

class _CreateAccountState extends State<CreateAccountPage> {
  // Create firebase instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // Key for form
  final _formKey = GlobalKey<FormState>();

  RegExp _emailExp = RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");


  // Form data
  String _name;
  String _email;
  String _password;
  bool _accessCsm = false;
  bool _accessSermonNotes = false;
  bool _accessEvents = false;
  bool _accessNotices = false;
  bool _accessAdmin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Create Account'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Form(
            key: _formKey,
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * .98,
                constraints: BoxConstraints(maxWidth: 500.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 8),
                      child: Text(
                        'Account Details',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ),
                    CTextInput(label: 'Full Name', validator: (value) {
                      if (value.isEmpty) {
                        return 'Please fill out your full name';
                      } else {
                        _name = value;
                        return null;
                      }
                    }, isPassword: false),
                    SizedBox(height: 8.0),
                    CTextInput(label: 'Email', validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter an email address';
                      } else if (!_emailExp.hasMatch(value)) {
                        return 'Please enter a valid email address';
                      } else {
                        _email = value;
                        return null;
                      }
                    }, isPassword: false),
                    SizedBox(height: 8.0),
                    CTextInput(label: 'Password', validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a password';
                      } else if (value.length < 8) {
                        return 'Password must be more then 7 characters';
                      } else {
                        _password = value;
                        return null;
                      }
                    }, isPassword: true),
                    SizedBox(height: 8.0),
                    CTextInput(label: 'Confirm Password', validator: (value) {
                      if (value.isEmpty) {
                        return 'Please confirm the password';
                      } else if (value != _password) {
                        return 'Passwords do not match';
                      } else {
                        return null;
                      }
                    }, isPassword: true),
                    Container(
                      margin: EdgeInsets.only(top: 20.0),
                      child: Text(
                        'User Permissions',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        // Check Box
                        Container(
                          margin: EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Text('CSM'),
                              Checkbox(
                                value: _accessCsm,
                                onChanged: (value) {
                                  setState(() {
                                    _accessCsm = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),

                        // Check Box
                        Container(
                          margin: EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Text('Sermon Notes'),
                              Checkbox(
                                value: _accessSermonNotes,
                                onChanged: (value) {
                                  setState(() {
                                    _accessSermonNotes = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),

                        // Check Box
                        Container(
                          margin: EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Text('Events'),
                              Checkbox(
                                value: _accessEvents,
                                onChanged: (value) {
                                  setState(() {
                                    _accessEvents = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Text('Notices'),
                              Checkbox(
                                value: _accessNotices,
                                onChanged: (value) {
                                  setState(() {
                                    _accessNotices = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Text('Admin'),
                              Checkbox(
                                value: _accessAdmin,
                                onChanged: (value) {
                                  setState(() {
                                    _accessAdmin = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: CButton(text: 'Create', onPressedAction: () {
                        if (_formKey.currentState.validate()) {
                            _createAccount().then((value) => Navigator.pop(context)).catchError((error) {
                              print('Error on account creation: $error');
                            });
                        }
                      }),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<FirebaseUser> _createAccount() async {
    List _permissions = [];

    // Convert permissions into list
    if (_accessCsm) {
      _permissions.add('csm');
    }
    if (_accessSermonNotes) {
      _permissions.add('sermon-notes');
    }
    if (_accessEvents) {
      _permissions.add('events');
    }
    if (_accessNotices) {
      _permissions.add('notices');
    }
    if (_accessAdmin) {
      _permissions.add('admin');
    }

    final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
            email: _email, password: _password))
        .user;

    Firestore.instance.collection('users').document(user.uid).setData({
      'name': _name,
      'permissions': _permissions,
    });

    return user;
  }
}