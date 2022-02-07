import 'package:flutter/material.dart';
import 'package:project2/screens/home/bus_jsonparse.dart';

class BusCode extends StatefulWidget {
  @override
  State<BusCode> createState() => _BusCodeState();
}

class _BusCodeState extends State<BusCode> {
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 180),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(5.0),
                ),
              ),
              filled: true,
              fillColor: Colors.white60,
              contentPadding: EdgeInsets.all(15.0),
              hintText: 'Input Bus Stop Code',
            ),
            controller: myController,
          ),
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => bus_timing(
                    busstopcode: (myController.text.toString()),
                  ),
                ),
              );
            },
            child: const Icon(Icons.bus_alert_sharp),
          ),
        ],
      ),
    );
  }
}
