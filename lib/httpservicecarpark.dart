// ignore_for_file: deprecated_member_use
import 'package:http/http.dart' as http;
import 'package:project2/screens/home/carparks.dart';

class HttpService {
  static const String url =
      'http://datamall2.mytransport.sg/ltaodataservice/CarParkAvailabilityv2';
  static Future<List<Value>> getCarparks() async {
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'AccountKey': 'SQcoGZ9CQy6jokPPFAyRrg==',
        'accept': 'application/json'
      });
      if (response.statusCode == 200) {
        final Carparks cp = carparksFromJson(response.body);
        return cp.value;
      } else {
        return List<Value>();
      }
    } catch (e) {
      print('Error ${e.toString()}');
      return List<Value>();
    }
  } //getCarparks
} //HttpService