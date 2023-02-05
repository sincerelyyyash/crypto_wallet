//https://api.coingecko.com/api/v3/coins/
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<double> getPrice(String id) async {
  try {
    var apiUrl =
        "https://api.coingecko.com/api/v3/simple/price?ids=$id&vs_currencies=inr";
    print(apiUrl);
    final Uri url = Uri.parse(apiUrl);
    var response = await http.get(url);
    var json = jsonDecode(response.body);
    print(id);
    var value = json[id]['inr'].toString();
    print(value);
    return double.parse(value);
  } catch (e) {
    print(e.toString());
    return 0.0;
  }
}
