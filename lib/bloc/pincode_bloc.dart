import 'package:rxdart/rxdart.dart';

import 'package:svgs_app/model/pincode_model.dart';
import 'package:svgs_app/networking/repository.dart';

class PincodeBloc {
  final _repository = Repository();
  final _pincodeFetcher = PublishSubject<PincodeModel>();

  Stream<PincodeModel> get allAreaPin => _pincodeFetcher.stream;

  fetchAllAreas(String search_name) async {
    PincodeModel itemModel = await _repository.fetchAllAreas(search_name);
    _pincodeFetcher.sink.add(itemModel);
  }

  dispose() {
    _pincodeFetcher.close();
  }
}
final bloc = PincodeBloc();