import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:news_api_rapid/controller/controller.dart';
import 'package:news_api_rapid/model/model.dart';


final GetDataController getDataController = Get.put(GetDataController());

class DataService {
  String apiUrl = getDataController.searchItemController.value.text.isNotEmpty
      ? 'https://duckduckgo10.p.rapidapi.com/search/news?term=${getDataController.searchItemController.value.text}&region=in-en&safeSearch=off'
      : 'https://duckduckgo10.p.rapidapi.com/search/news?term=india&region=in-en&safeSearch=off';

  Future<WelcomeSuccess> getData() async {
    try {
      final response = await http.get(Uri.parse(apiUrl), headers: {
        'X-RapidAPI-Key': '6b33c0d435msh83caf79e8b731bbp15959djsn26626e4302fa',
        'X-RapidAPI-Host': 'duckduckgo10.p.rapidapi.com',
      });

      debugPrint(response.body);

      if (response.statusCode == 200) {
        debugPrint('200 success');
        return welcomeSuccessFromJson(response.body);
      } else {
        throw Exception('Failed to post exception');
      }
    } catch (e) {
      throw Exception('Failed to get data in service $e');
    }
  }
}
