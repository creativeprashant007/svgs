import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' show Client, Response;
import 'package:svgs_app/model/Category_Pro_Model.dart';
import 'package:svgs_app/model/pincode_model.dart';

class ApiProvider {
  Client client = Client();
  final _apiKey = 'api-key';
  final _baseUrl = "http://www.graceonline.in/api/gr/v1";
  final quickBuy = "http://quickbuy.svgs.co/quickbuy";

  Future<PincodeModel> fetchAreaList(String search_name) async {
    Response response;
    /* if(search_name != 'api-key') {*/
    final url = Uri.parse("$_baseUrl/area-search?search=$search_name");
    response = await client.get(url);
    /*}else{
      throw Exception('Please add your API key');
    }*/

    print("asdasdasdasdasdasdasd:$_baseUrl/area-search?search=$search_name");
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      print("ASFASFAFAAasdasfsfs:$response");
      return PincodeModel.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<Category_Pro_Model> fetchCatPro(String cat_slug, String page_id,
      String brch_id, String mem_id, String unique_id) async {
    Response response;
    /* if(search_name != 'api-key') {*/

    final url = Uri.parse("$_baseUrl/ct?cat_slug=$cat_slug" +
        "&=page_id$page_id" +
        "&=brch_id$brch_id" +
        "&=unique_id$unique_id");
    response = await client.get(url);
    /*}else{
      throw Exception('Please add your API key');
    }*/

    print("cat_url:$_baseUrl/ct?cat_slug=$cat_slug" +
        "&=page_id$page_id" +
        "&=brch_id$brch_id" +
        "&=unique_id$unique_id");
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      print("ASFASFAFAAasdasfsfs:$response");
      return Category_Pro_Model.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

/*  Future<TrailerModel> fetchTrailer(int movieId) async {
    final response =
    await client.get("$_baseUrl/$movieId/videos?api_key=$_apiKey");

    if (response.statusCode == 200) {
      return TrailerModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load trailers');
    }
  }*/

}
