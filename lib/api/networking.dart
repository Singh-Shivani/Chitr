import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey = "jRBzm2zUw2eoIPSHZxLvY_hnSh0P8J91P2THDay4y8w";

const apiUrl = 'https://api.unsplash.com/photos?client_id=$apiKey';

class FetchImages {
  Future getLatestImages(int pageNumber) async {
    String url =
        '$apiUrl&order_by=latest&orientation=portrait&&per_page=15&page=$pageNumber';
    http.Response response = await http.get(url);

    List responseData = [];

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      for (var i in data) {
        if (i['height'] > i['width']) {
          //to only select portraits images in the list
          List listData = [];
          listData.add(i['id']);
          listData.add(i['blur_hash']);
          listData.add(i['urls']['regular']);
          listData.add(i['urls']['thumb']);
          listData.add(i['links']['download']);
          responseData.add(listData);
        }
      }
      // for (var i in data) {
      //   //to only select portraits images in the list
      //   List listData = [];
      //   listData.add(i['id']);
      //   listData.add(i['blur_hash']);
      //   listData.add(i['urls']['regular']);
      //   listData.add(i['urls']['thumb']);
      //   listData.add(i['links']['download']);
      //   responseData.add(listData);
      // }
    } else {
      print(response.statusCode);
    }
    return responseData;
  }

  Future getTrendingImages(int pageNumber) async {
    String url =
        '$apiUrl&order_by=popular&orientation=portrait&&per_page=15&page=$pageNumber';
    http.Response response = await http.get(url);

    List responseData = [];

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      for (var i in data) {
        if (i['height'] > i['width']) {
          //to only select portraits images in the list
          List listData = [];
          listData.add(i['id']);
          listData.add(i['blur_hash']);
          listData.add(i['urls']['regular']);
          listData.add(i['urls']['thumb']);
          listData.add(i['links']['download']);
          responseData.add(listData);
        }
      }
    } else {
      print(response.statusCode);
    }
    return responseData;
  }

  Future getSearchedImages(int pageNumber, String query) async {
    String url =
        'https://api.unsplash.com/search/photos?client_id=$apiKey&query=$query&orientation=portrait&page=$pageNumber';
    http.Response response = await http.get(url);

    List responseData = [];

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);

      for (var i in data['results']) {
        if (i['height'] > i['width']) {
          //to only select portraits images in the list
          List listData = [];
          listData.add(i['id']);
          listData.add(i['blur_hash']);
          listData.add(i['urls']['regular']);
          listData.add(i['urls']['thumb']);
          listData.add(i['links']['download']);
          responseData.add(listData);
        } else {
          print(response.statusCode);
        }
      }
    }

    return responseData;
  }
}
