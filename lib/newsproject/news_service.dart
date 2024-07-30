import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import 'news_model_screen.dart';

class NewsProvider extends ChangeNotifier {
  final NewsServices _newsServices = NewsServices();
  bool _loading = false;
  NewsModel? _newsSearchModel;

  bool get loading => _loading;
  NewsModel? get newsSearchModel => _newsSearchModel;

  Future<void> fetchNews(String category, [String? query]) async {
    _loading = true;
    notifyListeners();

    try {
      var newsSearchModel = await _newsServices.getNews(category, query);
      _newsSearchModel = newsSearchModel;
    } catch (e) {
      _newsSearchModel = null;
      print(e);
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  List<Map<String, String>> _favourites = [];
  MyProvider() {
    loadFavourites();
  }

  Future<void> loadFavourites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favourites = prefs.getStringList('favourites');
    if (favourites != null) {
      _favourites = favourites.map((item) {
        var parts = item.split('|');
        return {
          'name': parts.isNotEmpty ? parts[0] : '',
          'description': parts.length > 1 ? parts[1] : '',
          'image': parts.length > 2 ? parts[2] : '',
        };
      }).toList();
    }
    notifyListeners();
  }

  Future<void> addFavourite(String name, String description, String image) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _favourites.add({'name': name, 'description': description, 'image': image});
    List<String> favourites = _favourites.map((item) => '${item['name']}|${item['description']}|${item['image']}').toList();
    await prefs.setStringList('favourites', favourites);
    notifyListeners();
  }

  Future<void> deleteData(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _favourites.removeAt(index);
    List<String> favourites = _favourites.map((item) => '${item['name']}|${item['description']}|${item['image']}').toList();
    await prefs.setStringList('favourites', favourites);
    notifyListeners();
  }

  List<Map<String, String>> get favourites => _favourites;
}

class NewsServices {
  final String url = "https://newsapi.org/v2/top-headlines";
  final String apiKey = "4ca191aa40cc41938eccd51df0c54b3a";

  Future<NewsModel> getNews(String category, [String? query]) async {
    var fullUrl = Uri.parse("$url?country=us&category=$category&apiKey=$apiKey");
    if (query != null && query.isNotEmpty) {
      fullUrl = Uri.parse("$url?country=us&category=$category&q=$query&apiKey=$apiKey");
    }

    try {
      var response = await http.get(fullUrl);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return NewsModel.fromJson(data);
      } else {
        throw Exception('Failed to load data: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load data');
    }
  }
}