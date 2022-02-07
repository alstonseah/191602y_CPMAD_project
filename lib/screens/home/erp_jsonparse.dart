import 'package:flutter/material.dart';
import 'dart:async';

import '../../httpserviceerp.dart';
import 'ERP.dart';
import 'package:intl/intl.dart';
import 'package:project2/shared/constants.dart';

class ERP extends StatefulWidget {
  ERP({Key key}) : super(key: key);
  @override
  State<ERP> createState() => _ERPState();
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

class _ERPState extends State<ERP> {
  final debouncer = Debouncer(msecond: 1000);
  List<Value> _erp;
  bool _loading;
  @override
  void initState() {
    super.initState();
    _loading = true;
    HttpService.getERPrates().then((erp) {
      setState(() {
        _erp = erp;
        _loading = false;
      });
    });
  }

  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          searchTF(),
          Expanded(
            child: ListView.builder(
              itemCount: null == _erp ? 0 : _erp.length,
              itemBuilder: (context, index) {
                Value erprates = _erp[index];
                return Card(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Vehicle Type: ' +
                              erprates.vehicleType.toString().split('.').last,
                          style: TextStyle(fontSize: 14.0, color: Colors.black),
                        ),
                        SizedBox(height: 5.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ' Day Type:  ' +
                                  ((erprates.dayType.toString().split('.').last)
                                          .toLowerCase())
                                      .capitalize(),
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.black87),
                            ),
                            Text(
                              'StartTime:  ' +
                                  erprates.startTime.toString() +
                                  ' to ' +
                                  erprates.endTime.toString(),
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.black87),
                            ),
                            Text(
                              'ZoneID:  ' +
                                  erprates.zoneId.toString().split('.').last,
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.black87),
                            ),
                            Text(
                              'Charge:  ' + erprates.chargeAmount.toString(),
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.black87),
                            ),
                            Text(
                              'EffectiveDate:  ' +
                                  formatter
                                      .format(erprates.effectiveDate)
                                      .toString(),
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
    );
  }

  Widget searchTF() {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(5.0),
          ),
        ),
        filled: true,
        fillColor: Colors.white60,
        contentPadding: EdgeInsets.all(15.0),
        hintText: 'Filter by Zone ID',
      ),
      onChanged: (string) {
        debouncer.run(() {
          HttpService.getERPrates().then((uerp) {
            setState(() {
              _erp = Value.filterList(uerp, string);
            });
          });
        });
      },
    );
  }
}
