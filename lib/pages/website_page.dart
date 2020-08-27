import 'package:flutter/material.dart';

import '../widgets/cag_text_form.dart';
import '../widgets/cag_menu_item.dart';

class WebsitePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 1000.0),
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 1.4,
          children: <Widget>[
            CMenuItem(
              backgroundImage: AssetImage('assets/images/cafe.jpg'),
              whiteText: true,
              text: 'Cafe',
              routeName: '/cafeEditor',
            ),
            CMenuItem(
              routeName: '',
              text: 'Slides',
              backgroundImage: AssetImage('assets/images/events.jpg'),
            ),
            CMenuItem(
              routeName: '/notesEditor',
              text: 'Notes',
              backgroundImage: AssetImage('assets/images/notes.jpg'),
            ),
          ],
        ),
      ),
    );
  }
}

class CafePage extends StatelessWidget {
  // TODO: Get data from firebase here
  final String _cafeDate = "2/23/22";
  final List<dynamic> _cafeItems = ['item 1', 'item 2', 'item 3'];
  final _cafeFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cafe Editor'),
        elevation: 0,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                // TODO: Write to firebase here
                Navigator.pop(context);
              })
        ],
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 600.0),
          child: Container(
            margin: EdgeInsets.all(8.0),
            child: Form(
              key: _cafeFormKey,
              child: ListView(
                children: <Widget>[
                  Text('Date'),
                  CTextInput(
                      label: 'Date',
                      validator: (value) {},
                      isPassword: false,
                      controller: TextEditingController(text: _cafeDate)),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text('Items'),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: _cafeItems.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(top: 8.0),
                        child: CTextInput(
                          label: 'Item',
                          validator: (value) {},
                          isPassword: false,
                          controller:
                              TextEditingController(text: _cafeItems[index]),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NotesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Notes"),
      ),
      body: Form(
          child: Column(
        children: <Widget>[],
      )),
    );
  }
}
