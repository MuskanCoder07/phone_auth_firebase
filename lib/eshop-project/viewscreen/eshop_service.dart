import 'dart:convert';
import 'package:http/http.dart' as http;
import 'e-shop_model_class.dart';


class EshopService {
  Future<EShopeModel> getShopData() async {
    var headers = {
      'Authorization': 'Basic ${base64Encode(utf8.encode('tasty.p.rapidapi.com:6c8f902cffmshf90d40a5fdc6d12p18faf7jsnbcaa8c5e2420'))}'
    };

    var response = await http.get(
      Uri.parse("https://dummyjson.com/products"),
      headers: headers,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return EShopeModel.fromJson(data);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
