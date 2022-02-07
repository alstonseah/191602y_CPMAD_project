import 'package:flutter/material.dart';
import 'package:project2/screens/home/about.dart';
import 'package:project2/screens/home/buscode.dart';
import 'package:project2/screens/home/carpark_jsonparser.dart';
import 'package:project2/screens/home/drawer.dart';
import 'package:project2/screens/home/erp_jsonparse.dart';
import 'package:project2/screens/home/mrtmap.dart';
import 'package:project2/screens/home/settings_form.dart';
import 'package:project2/services/auth.dart';
import 'package:project2/services/database.dart';
import 'package:provider/provider.dart';
import 'package:project2/models/profile.dart';
import 'package:project2/screens/home/profile_list.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  String title = 'Home';
  int index = 0;
  List<Widget> list = [
    ProfileList(),
    About(),
    mrtmap(),
    ERP(),
    BusCode(),
    carpark()
  ];
  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 60.0,
              ),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Profile>>.value(
      value: DatabaseService().profile,
      child: Scaffold(
        backgroundColor: Colors.red[50],
        appBar: AppBar(
          title: Text(title),
          backgroundColor: Colors.red[700],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('logout'),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text('settings'),
              onPressed: () => _showSettingsPanel(),
            ),
          ],
        ),
        body: list[index],
        drawer: MyDrawer(onTap: (context, i, txt) {
          setState(() {
            index = i;
            title = txt;
            Navigator.pop(context);
          });
        }),
      ),
    );
  }
}
