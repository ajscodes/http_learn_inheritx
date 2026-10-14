import 'dart:convert';
import 'package:networking_learn/models/api_model.dart';
import 'package:http/http.dart' as http;
import 'package:networking_learn/utils/url_constants.dart';

class ApiServices {
  Future<List<ApiModel>> fetchDate() async {
    try{
      final url = UrlConstants.baseUrl+UrlConstants.posts;
      final response = await http.get(Uri.parse(url));

      if(response.statusCode == 200){
        List<dynamic> jsonData = jsonDecode(response.body);

        List<ApiModel> apiItems = jsonData.map((item) => ApiModel.fromJson(item)).toList();

        return apiItems;

      }else{
        throw Exception('Failed to load. Status code : ${response.statusCode}');
      }
    }catch (e){
      throw Exception('Error : $e');
    }
  }
}