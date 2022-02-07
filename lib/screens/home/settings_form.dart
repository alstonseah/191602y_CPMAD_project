import 'package:flutter/material.dart';
import 'package:project2/models/user.dart';
import 'package:project2/services/database.dart';
import 'package:project2/shared/constants.dart';
import 'package:flutter/services.dart';
import 'package:project2/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> gender = ['Male', 'Female'];

  //form values
  String _currentName;
  String _currentGender;
  int _currentAge;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<TheUser>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;

            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    "Update Your Details.",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: textInputDecoration,
                    validator: (val) =>
                        val.isEmpty ? "Please enter a name" : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(height: 20.0),
                  //dropdown
                  DropdownButtonFormField(
                      value: _currentGender ?? userData.gender,
                      decoration: textInputDecoration,
                      items: gender.map((gender) {
                        return DropdownMenuItem(
                          value: gender,
                          child: Text('$gender'),
                        );
                      }).toList(),
                      onChanged: (val) => setState(() => _currentGender = val)),
                  SizedBox(height: 20.0),
                  Text(
                    (_currentAge ?? userData.age).toString(),
                    style:
                        TextStyle(fontSize: 15.0, fontWeight: FontWeight.w900),
                  ),
                  //slider
                  Slider(
                    value: (_currentAge ?? userData.age).toDouble(),
                    activeColor: Colors.pink[800],
                    inactiveColor: Colors.pink[400],
                    min: 0.0,
                    max: 95.0,
                    divisions: 95,
                    onChanged: (val) =>
                        setState(() => _currentAge = val.round()),
                  ),

                  RaisedButton(
                      color: Colors.pink[400],
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          await DatabaseService(uid: user.uid).updateUserData(
                              _currentName ?? userData.name,
                              _currentGender ?? userData.gender,
                              _currentAge ?? userData.age);
                          Navigator.pop(context);
                        }
                      })
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
