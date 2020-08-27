import 'package:co_manager/style/text_styles.dart';
import 'package:flutter/material.dart';

// Page Imports
import '../pages/alerts_page.dart';
import '../pages/csm_page.dart';
import '../pages/website_page.dart';

// Firebase
// ## Offical Firebase ##
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// User Imports
import 'package:scoped_model/scoped_model.dart';
import '../objects/user.dart';

// Widgets
import 'package:co_manager/widgets/cag_button.dart';

class Portal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(
      builder: (context, child, user) {
        return DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: TabBar(
                isScrollable: true,
                tabs: <Widget>[
                  // Home Tab
                  Container(
                    width: 30.0,
                    child: Tab(
                      icon: Icon(Icons.home),
                    ),
                  ),
                  // Website Tab
                  Tab(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(Icons.web),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text('WEBSITE'),
                      ],
                    ),
                  ),
                  // Alerts Tab
                  Tab(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(Icons.alarm),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text('ALERTS'),
                      ],
                    ),
                  ),
                  // CSM
                  user.permCSM()
                      ? Tab(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(Icons.tv),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text('CSM'),
                            ],
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                HomePage(),
                WebsitePage(),
                AlertsPage(),
                CSMPage(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(
      builder: (context, child, user) {
        return Container(
          margin: EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Login buttons
                  Row(
                    children: <Widget>[
                      CButton(
                          text: 'Logout',
                          onPressedAction: () {
                            FirebaseAuth.instance.signOut();
                            Navigator.pushReplacementNamed(context, '/');
                          }),
                      // Checks to see if user is ADMIN or not
                      user.permAdmin()
                          ? CButton(
                              text: 'Create Account',
                              onPressedAction: () {
                                Navigator.of(context).pushNamed('/signup');
                              })
                          : SizedBox(),
                      Text('Welcome ' + user.fullName + "!"),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),

                  // Change Log
                  Text(
                    'Change Log',
                    style: headerTextStyle,
                  ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Text('- First Build!'),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),

                  // Status Data
                  Text(
                    'Status',
                    style: headerTextStyle,
                  ),

                  // Cafe Status
                  StreamBuilder(
                    // ## Offical Firebase ##
                    // Firestore.instance.collection('cafe-menu').document('wednesday').snapshot()
                    stream: Firestore.instance
                        .collection('cafe-menu')
                        .document('wednesday')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        print(snapshot.error);
                        return Icon(Icons.error);
                      } else {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return CircularProgressIndicator();
                          default:
                            {
                              Map<String, dynamic> documentData;
                              documentData = snapshot.data.data;
                              String menuItems = '';

                              for (int i = 0;
                                  i < documentData['items'].length;
                                  i++) {
                                menuItems +=
                                    documentData['items'][i].toString() + '\n';
                              }

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Cafe Menu'),
                                  Text(documentData['date']),
                                  Text(menuItems),
                                ],
                              );
                            }
                        }
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
