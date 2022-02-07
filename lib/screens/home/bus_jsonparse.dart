import 'package:flutter/material.dart';
import 'dart:async';
import 'package:project2/httpservicebus.dart';
import 'BusTiming.dart';
import 'package:intl/intl.dart';

class bus_timing extends StatefulWidget {
  final busstopcode;
  bus_timing({Key key, this.busstopcode}) : super(key: key);
  @override
  State<bus_timing> createState() => _bus_timingState();
}

class Debouncer {
  final int msecond;
  VoidCallback action;
  Timer _timer;
  Debouncer({this.msecond});
  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: msecond), action);
  }
}

class _bus_timingState extends State<bus_timing> {
  final debouncer = Debouncer(msecond: 1000);
  List<Service> _bt;
  bool _loading;
  @override
  void initState() {
    super.initState();
    _loading = true;
    HttpService.getBusTiming(widget.busstopcode).then((bt) {
      setState(() {
        _bt = bt;
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[50],
      appBar: AppBar(
        title: Text('Bus Arrival Timings'),
        backgroundColor: Colors.red[700],
        elevation: 0.0,
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: null == _bt ? 0 : _bt.length,
                itemBuilder: (context, index) {
                  Service bustiming = _bt[index];
                  return Card(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bus No.: ' + bustiming.serviceNo,
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.black),
                          ),
                          SizedBox(height: 5.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ' Next bus arriving at:  ' +
                                    (bustiming.nextBus.estimatedArrival
                                        .toString()
                                        .split('T')
                                        .last
                                        .split('+')
                                        .first
                                        .toString()),
                                style: TextStyle(
                                    fontSize: 14.0, color: Colors.black87),
                              ),
                              Text(
                                ' 2nd bus arriving at:  ' +
                                    (bustiming.nextBus2.estimatedArrival
                                        .toString()
                                        .split('T')
                                        .last
                                        .split('+')
                                        .first
                                        .toString()),
                                style: TextStyle(
                                    fontSize: 14.0, color: Colors.black87),
                              ),
                              Text(
                                ' 3rd bus arriving at:  ' +
                                    (bustiming.nextBus3.estimatedArrival
                                        .toString()
                                        .split('T')
                                        .last
                                        .split('+')
                                        .first
                                        .toString()),
                                style: TextStyle(
                                    fontSize: 14.0, color: Colors.black87),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget duration(String next) {
  //   next.toString().split('T').last,
  // }
}
