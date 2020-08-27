import 'package:co_manager/widgets/cag_button.dart';
import 'package:flutter/material.dart';

import '../widgets/cag_text_form.dart';

class AlertsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AlertsPageState();
}

class _AlertsPageState extends State<AlertsPage> {
  final _alertKey = GlobalKey<FormState>();
  final DateTime _todaysDate = DateTime.now();

  DateTime _startDate;
  DateTime _endDate;
  String _message;

  Future selectStartDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _todaysDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _todaysDate) {
      setState(() {
        _startDate = picked;
      });
    }
  }

  Future selectEndDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _todaysDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _todaysDate) {
      setState(() {
        _endDate = picked;
      });
    }
  }

  @override
  void initState() {
    // TODO: Connect variables to firebase
    // Load in the variables
    _startDate = DateTime.now();
    _endDate = DateTime.now();
    _message = 'Template Text';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 600.0),
        child: Form(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 8.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Alert Message'),
              ),
              CTextInput(label: 'Message', validator: (value) {}, isPassword: false, controller: TextEditingController(text: _message),),
              SizedBox(
                height: 16.0,
              ),
              // Date Selector
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Start Date
                  Column(
                    children: <Widget>[
                      Text('Start Date'),
                      FlatButton.icon(
                        onPressed: () {
                          selectStartDate(context);
                        },
                        icon: Icon(Icons.calendar_today),
                        label: Text(_startDate.month.toString() +
                            '/' +
                            _startDate.day.toString() +
                            '/' +
                            _startDate.year.toString()),
                      ),
                    ],
                  ),
                  // End Date
                  Column(
                    children: <Widget>[
                      Text('End Date'),
                      FlatButton.icon(
                        onPressed: () {
                          selectEndDate(context);
                        },
                        icon: Icon(Icons.calendar_today),
                        label: Text(_endDate.month.toString() +
                            '/' +
                            _endDate.day.toString() +
                            '/' +
                            _endDate.year.toString()),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CButton(text: 'Clear All', secondStyle: true, onPressedAction: () {},),
                  CButton(
                      text: 'Publish',
                      onPressedAction: () {
                        if (_alertKey.currentState.validate()) {
                          // If input is validated

                        }
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
