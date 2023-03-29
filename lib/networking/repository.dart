import 'dart:async';
import 'package:svgs_app/model/Category_Pro_Model.dart';
import 'package:svgs_app/model/pincode_model.dart';
import 'package:svgs_app/networking/api_provider.dart';

//import file
class Repository {
  final pincodeApiProvider = ApiProvider();
  final catproApiProvide = ApiProvider();

  Future<PincodeModel> fetchAllAreas(String search_name) =>
      pincodeApiProvider.fetchAreaList(search_name);

  Future<Category_Pro_Model> fetchAllCatPro(String cat_slug, String page_id,
          String brch_id, String mem_id, String unique_id) =>
      catproApiProvide.fetchCatPro(
          cat_slug, page_id, brch_id, mem_id, unique_id);
}
