import 'package:http/http.dart' as http;
import 'package:project2/screens/home/ERP.dart';

class HttpService {
  static const String url =
      'http://datamall2.mytransport.sg/ltaodataservice/ERPRates';
  static Future<List<Value>> getERPrates() async {
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'AccountKey': 'SQcoGZ9CQy6jokPPFAyRrg== ',
        'accept': 'application/json'
      });
      if (response.statusCode == 200) {
        final Erp cp = erpFromJson(response.body);
        return cp.value;
      } else {
        return List<Value>();
      }
    } catch (e) {
      print('Error ${e.toString()}');
      return List<Value>();
    }
  } //getCarparks
}
