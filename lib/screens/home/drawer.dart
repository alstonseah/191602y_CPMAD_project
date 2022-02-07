import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project2/models/profile.dart';
import 'package:project2/models/user.dart';
import 'package:project2/services/database.dart';
import 'package:project2/shared/loading.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  final Function onTap;
  MyDrawer({this.onTap});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<TheUser>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Drawer(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  DrawerHeader(
                    decoration: BoxDecoration(color: Colors.indigo[900]),
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              userData.name,
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ]),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text('Home'),
                    onTap: () => onTap(context, 0, 'Home'),
                  ),
                  ListTile(
                    leading: Icon(Icons.support_agent),
                    title: Text('About'),
                    onTap: () => onTap(context, 1, 'About'),
                  ),
                  ListTile(
                    leading: Icon(Icons.train_outlined),
                    title: Text('MRT Map'),
                    onTap: () => onTap(context, 2, 'MRT Map'),
                  ),
                  ListTile(
                    leading: Icon(Icons.motorcycle_rounded),
                    title: Text('ERP Rates'),
                    onTap: () => onTap(context, 3, 'ERP Rates'),
                  ),
                  ListTile(
                    leading: Icon(Icons.bus_alert),
                    title: Text('Bus timings'),
                    onTap: () => onTap(context, 4, 'Bus Timings'),
                  ),
                  ListTile(
                    leading: Icon(Icons.local_parking),
                    title: Text('Carpark Availability'),
                    onTap: () => onTap(context, 5, 'Carpark Availability'),
                  ),
                ],
              )),
            );
          } else {
            return Loading();
          }
        });
  }
}
