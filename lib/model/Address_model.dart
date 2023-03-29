class address {
  final int status;
  final String message;
  List<AreaDetails> areaDetails;

  address({this.status, this.message, this.areaDetails});
}

class AreaDetails {
  String id;
  String area_name;
  String area_latitute;
  String area_longitute;
  String area_pincode;
  String area_city;
  String area_state;
  String area_country;
  String area_status;

  AreaDetails({
    this.id,
    this.area_name,
    this.area_latitute,
    this.area_longitute,
    this.area_pincode,
    this.area_city,
    this.area_state,
    this.area_country,
    this.area_status,
  });

  AreaDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    area_name = json['area_name'];
    area_latitute = json['area_latitute'];
    area_longitute = json['area_longitute'];
    area_pincode = json['area_pincode'];
    area_city = json['area_city'];
    area_state = json['area_state'];
    area_country = json['area_country'];
    area_status = json['area_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['area_name'] = this.area_name;
    data['area_latitute'] = this.area_latitute;
    data['area_longitute'] = this.area_longitute;
    data['area_pincode'] = this.area_pincode;
    data['area_city'] = this.area_city;
    data['area_state'] = this.area_state;
    data['area_country'] = this.area_country;
    data['area_status'] = this.area_status;
    return data;
  }
}
