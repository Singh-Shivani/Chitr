import 'package:chitrwallpaperapp/modal/responeModal.dart';
import 'package:chitrwallpaperapp/modal/topic.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey = "jRBzm2zUw2eoIPSHZxLvY_hnSh0P8J91P2THDay4y8w";

const apiUrl = 'https://api.unsplash.com/photos?client_id=$apiKey';

const mainUrl = 'https://api.unsplash.com';

class FetchImages {
  Future getLatestImages(int pageNumber) async {
    String url =
        '$apiUrl&order_by=latest&orientation=portrait&&per_page=15&per_page=20&page=$pageNumber';
    http.Response response = await http.get(url);

    List<UnPlashResponse> unPlashResponseList = [];
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (var i = 0; i < data.length; i++) {
        UnPlashResponse unPlashResponse = new UnPlashResponse.fromJson(data[i]);
        unPlashResponseList.add(unPlashResponse);
      }
    } else {
      print(response.statusCode);
    }
    return unPlashResponseList;
  }

  Future getCategory() async {
    String url = '$mainUrl/topics?client_id=$apiKey&per_page=30';
    http.Response response = await http.get(url);

    List<Topics> topicsList = [];
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (var i = 0; i < data.length; i++) {
        Topics topics = new Topics.fromJson(data[i]);
        topicsList.add(topics);
      }
    } else {
      print(response.statusCode);
    }
    return topicsList;
  }

  Future getTopicImage(int pageNumber, String topicId) async {
    String url =
        '$mainUrl/topics/$topicId/photos?client_id=$apiKey&per_page=25&page=$pageNumber';
    http.Response response = await http.get(url);

    List<UnPlashResponse> unPlashResponseList = [];
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (var i = 0; i < data.length; i++) {
        UnPlashResponse unPlashResponse = new UnPlashResponse.fromJson(data[i]);
        unPlashResponseList.add(unPlashResponse);
      }
    } else {
      print(response.statusCode);
    }
    return unPlashResponseList;
  }

  Future getTrendingImages(int pageNumber) async {
    String url = '$apiUrl&order_by=popular&per_page=20&page=$pageNumber';
    http.Response response = await http.get(url);

    List<UnPlashResponse> unPlashResponseList = [];
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (var i = 0; i < data.length; i++) {
        UnPlashResponse unPlashResponse = new UnPlashResponse.fromJson(data[i]);
        unPlashResponseList.add(unPlashResponse);
      }
    } else {
      print(response.statusCode);
    }
    return unPlashResponseList;
  }

  Future getSearchedImages(int pageNumber, String query) async {
    String url =
        'https://api.unsplash.com/search/photos?client_id=$apiKey&per_page=20&query=$query&page=$pageNumber';
    http.Response response = await http.get(url);

    List<UnPlashResponse> unPlashResponseList = [];
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      for (var i = 0; i < data['results'].length; i++) {
        UnPlashResponse unPlashResponse =
            new UnPlashResponse.fromJson(data['results'][i]);
        unPlashResponseList.add(unPlashResponse);
      }
    } else {
      print(response.statusCode);
    }
    return unPlashResponseList;
  }
}
