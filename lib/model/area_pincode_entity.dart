import 'package:svgs_app/generated/json/base/json_convert_content.dart';

class AreaPincodeEntity with JsonConvert<AreaPincodeEntity> {
	List<AreaPincodeArea> areas;
	int success;
	int error;
}

class AreaPincodeArea with JsonConvert<AreaPincodeArea> {
	String id;
	String area;
	String pincode;
	String city;
	String state;
	String country;
}
