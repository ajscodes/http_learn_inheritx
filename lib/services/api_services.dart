import 'dart:convert';
import 'package:networking_learn/models/api_model.dart';
import 'package:http/http.dart' as http;
import 'package:networking_learn/utils/url_constants.dart';

class ApiServices {
  //region GET ALL
  Future<List<ApiModel>> fetchData() async {
    try {
      final response = await http.get(Uri.parse(UrlConstants.baseUrl));

      List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((item) => ApiModel.fromJson(item)).toList();

    } catch (e) {
      throw Exception('==== (API SERVICE) GET ALL EXCEPTION: $e');
    }
  }

  //endregion

  //region GET BY ID
  Future<ApiModel> getById(int id) async {
    try {
      final response = await http.get(Uri.parse('${UrlConstants.baseUrl}/$id'));

      Map<String, dynamic> apiItem = jsonDecode(response.body);
      return ApiModel.fromJson(apiItem);
    } catch (e) {
      throw Exception('==== (API SERVICE) GET BY ID EXCEPTION : $e');
    }
  }

  //endregion

  //region DELETE
  Future<void> deleteData(String id) async {
    try {
      await http.delete(Uri.parse('${UrlConstants.baseUrl}/$id'));
    } catch (e) {
      throw Exception('==== (API SERVICE) DELETE EXCEPTION : $e');
    }
  }
  //endregion

  //region POST
  Future<ApiModel> addData(ApiModel model) async {
    try {
      final response = await http.post(Uri.parse(UrlConstants.baseUrl), body: jsonEncode(model.toJson()));
      if(response.statusCode == 201){
        Map<String, dynamic> resData = jsonDecode(response.body);
        return ApiModel.fromJson(resData);
      }else{
        throw Exception('==== STATUS CODE RETURNED: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('==== (API SERVICE) POST EXCEPTION : $e');
    }
  }
  //endregion
}
