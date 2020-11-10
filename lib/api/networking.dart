import 'package:chitrwallpaperapp/modal/responeModal.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey = "jRBzm2zUw2eoIPSHZxLvY_hnSh0P8J91P2THDay4y8w";

const apiUrl = 'https://api.unsplash.com/photos?client_id=$apiKey';

class FetchImages {
  Future getLatestImages(int pageNumber) async {
    String url =
        '$apiUrl&order_by=latest&orientation=portrait&&per_page=15&page=$pageNumber';
    http.Response response = await http.get(url);

    List<UnPlashResponse> unPlashResponseList = [];
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (var i = 0; i < data.length; i++) {
        if (data[i]['height'] > data[i]['width']) {
          //to only select portraits images in the list
          UnPlashResponse unPlashResponse =
              new UnPlashResponse.fromJson(data[i]);
          unPlashResponseList.add(unPlashResponse);
        }
      }
    } else {
      print(response.statusCode);
    }
    return unPlashResponseList;
  }

  Future getTrendingImages(int pageNumber) async {
    String url =
        '$apiUrl&order_by=popular&orientation=portrait&&per_page=15&page=$pageNumber';
    http.Response response = await http.get(url);

    List<UnPlashResponse> unPlashResponseList = [];
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (var i = 0; i < data.length; i++) {
        if (data[i]['height'] > data[i]['width']) {
          //to only select portraits images in the list
          UnPlashResponse unPlashResponse =
              new UnPlashResponse.fromJson(data[i]);
          unPlashResponseList.add(unPlashResponse);
        }
      }
    } else {
      print(response.statusCode);
    }
    return unPlashResponseList;
  }

  Future getSearchedImages(int pageNumber, String query) async {
    String url =
        'https://api.unsplash.com/search/photos?client_id=$apiKey&query=$query&orientation=portrait&page=$pageNumber';
    http.Response response = await http.get(url);

    List<UnPlashResponse> unPlashResponseList = [];
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      for (var i = 0; i < data.length; i++) {
        if (data['results'][i]['height'] > data['results'][i]['width']) {
          //to only select portraits images in the list
          UnPlashResponse unPlashResponse =
              new UnPlashResponse.fromJson(data['results'][i]);
          unPlashResponseList.add(unPlashResponse);
        }
      }
    } else {
      print(response.statusCode);
    }
    return unPlashResponseList;
  }
}
