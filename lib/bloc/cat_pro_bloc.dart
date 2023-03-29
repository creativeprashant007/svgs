import 'package:rxdart/rxdart.dart';
import 'package:svgs_app/model/Category_Pro_Model.dart';

import 'package:svgs_app/networking/repository.dart';

class CatProBloc {
  final _repository = Repository();
  final _catproFetcher = PublishSubject<Category_Pro_Model>();

  Stream<Category_Pro_Model> get allCatPro => _catproFetcher.stream;

  fetchAllAreas(String cat_slug,String page_id,String brch_id,String mem_id,String unique_id) async {
    Category_Pro_Model itemModel = await _repository.fetchAllCatPro(cat_slug,page_id,brch_id,mem_id,unique_id);
    _catproFetcher.sink.add(itemModel);
  }

  void dispose() {
    _catproFetcher.close();
    //allCatPro.drain();
  }
}
final bloc_cat = CatProBloc();