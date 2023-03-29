import 'package:svgs_app/model/area_pincode_entity.dart';

areaPincodeEntityFromJson(AreaPincodeEntity data, Map<String, dynamic> json) {
	if (json['areas'] != null) {
		data.areas = new List<AreaPincodeArea>();
		(json['areas'] as List).forEach((v) {
			data.areas.add(new AreaPincodeArea().fromJson(v));
		});
	}
	if (json['success'] != null) {
		data.success = json['success']?.toInt();
	}
	if (json['error'] != null) {
		data.error = json['error']?.toInt();
	}
	return data;
}

Map<String, dynamic> areaPincodeEntityToJson(AreaPincodeEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.areas != null) {
		data['areas'] =  entity.areas.map((v) => v.toJson()).toList();
	}
	data['success'] = entity.success;
	data['error'] = entity.error;
	return data;
}

areaPincodeAreaFromJson(AreaPincodeArea data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id']?.toString();
	}
	if (json['area'] != null) {
		data.area = json['area']?.toString();
	}
	if (json['pincode'] != null) {
		data.pincode = json['pincode']?.toString();
	}
	if (json['city'] != null) {
		data.city = json['city']?.toString();
	}
	if (json['state'] != null) {
		data.state = json['state']?.toString();
	}
	if (json['country'] != null) {
		data.country = json['country']?.toString();
	}
	return data;
}

Map<String, dynamic> areaPincodeAreaToJson(AreaPincodeArea entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['area'] = entity.area;
	data['pincode'] = entity.pincode;
	data['city'] = entity.city;
	data['state'] = entity.state;
	data['country'] = entity.country;
	return data;
}