import 'dart:convert';

import 'package:chitrwallpaperapp/modal/appError.dart';
import 'package:http/http.dart' as http;

class ErrorHadling {
  apiErrorHadling(
    http.Response response,
  ) {
    var data = jsonDecode(response.body);
    ApiError apiError = new ApiError.fromJson(data);
    return apiError;
  }
}
