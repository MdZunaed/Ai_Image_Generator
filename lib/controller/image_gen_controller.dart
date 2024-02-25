import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ImageGeneratorController extends GetxController {
  final url = Uri.parse("https://api.openai.com/v1/images/generations");
  final headers = {"Content-Type": "application/json", "Authorization": "Bearer apiKey"};
  late final String imageUrl;
  bool loading = false;

  Future<bool> generateImage(String text) async {
    bool isSuccess = false;
    loading = true;
    update();
    var response = await http.post(url,
        headers: headers,
        body: jsonEncode({"model": "dall-e-3", "prompt": text, "n": 1, "size": "1024x1024"}));
    try {
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        log(data);
        imageUrl = data['data'][0]['url'].toString();
        log(imageUrl);
        isSuccess = true;
      } else {
        log('Error: ${response.statusCode}');
        log('Response body: ${response.body}');
        loading = false;
        update();
      }
    } catch (e) {
      log(e.toString());
    }
    return isSuccess;
    loading = false;
    update();
  }
}
