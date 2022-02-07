import 'package:http/http.dart' as http;
import 'package:project2/screens/home/BusTiming.dart';

class HttpService {
  static Future<List<Service>> getBusTiming(String busstopcode) async {
    String url =
        'http://datamall2.mytransport.sg/ltaodataservice/BusArrivalv2?BusStopCode=' +
            busstopcode;
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'AccountKey': 'SQcoGZ9CQy6jokPPFAyRrg==',
        'accept': 'application/json'
      });
      if (response.statusCode == 200) {
        final BusTimings cp = busTimingsFromJson(response.body);
        return cp.services;
      } else {
        return List<Service>();
      }
    } catch (e) {
      print('Error ${e.toString()}');
      return List<Service>();
    }
  }
} //HttpService