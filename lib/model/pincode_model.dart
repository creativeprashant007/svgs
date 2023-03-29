class PincodeModel {
List<Areas> areas;
int success;
int error;

PincodeModel({this.areas, this.success, this.error});

PincodeModel.fromJson(Map<String, dynamic> json) {
if (json['areas'] != null) {
areas = new List<Areas>();
json['areas'].forEach((v) {
areas.add(new Areas.fromJson(v));
});
}
success = json['success'];
error = json['error'];
}

Map<String, dynamic> toJson() {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (this.areas != null) {
		data['areas'] = this.areas.map((v) => v.toJson()).toList();
	}
	data['success'] = this.success;
	data['error'] = this.error;
	return data;
}
}

class Areas {
	String id;
	String area;
	String pincode;
	String city;
	String state;
	String country;

	Areas(
			{this.id, this.area, this.pincode, this.city, this.state, this.country});

	Areas.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		area = json['area'];
		pincode = json['pincode'];
		city = json['city'];
		state = json['state'];
		country = json['country'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['area'] = this.area;
		data['pincode'] = this.pincode;
		data['city'] = this.city;
		data['state'] = this.state;
		data['country'] = this.country;
		return data;
	}
}