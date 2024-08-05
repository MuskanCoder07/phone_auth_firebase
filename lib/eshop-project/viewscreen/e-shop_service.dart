import 'dart:convert';
import 'package:http/http.dart' as http;
import 'e-shop_model_class.dart';


class EshopService {
  Future<EShopeModel> getShopData() async {

    var response = await http.get(
      Uri.parse("https://dummyjson.com/products"),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return EShopeModel.fromJson(data);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
