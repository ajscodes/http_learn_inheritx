import 'dart:convert';
import 'package:networking_learn/models/api_model.dart';
import 'package:http/http.dart' as http;
import 'package:networking_learn/utils/url_constants.dart';

class ApiServices {

  //region GET ALL
  Future<List<ApiModel>> fetchData() async {
    try{
      final response = await http.get(Uri.parse(UrlConstants.baseUrl));

      if(response.statusCode == 200){
        List<dynamic> jsonData = jsonDecode(response.body);
        return jsonData.map((item) => ApiModel.fromJson(item)).toList();
      }else{
        throw Exception('Failed to load. Status code : ${response.statusCode}');
      }
    }catch (e){
      throw Exception('====API SERVICE CLASS GET ALL EXCEPTION: $e');
    }
  }
  //endregion

  //region GET BY ID
  Future<ApiModel> getById(int id) async {
    try{
      final url = UrlConstants.baseUrl;
      final response = await http.get(Uri.parse('$url/$id'));

      if(response.statusCode == 200){
        Map<String, dynamic> apiItem = jsonDecode(response.body);

        return ApiModel.fromJson(apiItem);
      }else{
        throw Exception('=====Failed to load. Status code : ${response.statusCode}');
      }
    }catch (e){
      throw Exception('====API SERVICE CLASS GET BY ID EXCEPTION : $e');
    }
  }
  //endregion

  //region DELETE
  Future<void> deleteData(int id) async {
    try{
      await http.delete(Uri.parse('${UrlConstants.baseUrl}/$id'));
    } catch (e){
      throw Exception('====API SERVICE CLASS DELETE EXCEPTION : $e');
    }
  }
  //endregion
}