
class CommonBranchDetails {
  String id;
  String brch_name;
  String brch_area;
  String brch_pincode;
  String brch_address;
  String brch_city;
  String brch_state;
  String brch_country;
  String brch_phone;
  String brch_mobile;

  bool isExpanded;

  CommonBranchDetails({
    this.id,
    this.brch_name,
    this.brch_area,
    this.brch_pincode,
    this.brch_address,
    this.brch_city,
    this.brch_state,
    this.brch_country,
    this.brch_phone,
    this.brch_mobile,
  });

  CommonBranchDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brch_name = json['brch_name'];
    brch_area = json['brch_area'];
    brch_pincode = json['brch_pincode'];
    brch_address = json['brch_address'];
    brch_city = json['brch_city'];
    brch_state = json['brch_state'];
    brch_country = json['brch_country'];
    brch_phone = json['brch_phone'];
    brch_mobile = json['brch_mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['brch_name'] = this.brch_name;
    data['brch_area'] = this.brch_area;
    data['brch_pincode'] = this.brch_pincode;
    data['brch_address'] = this.brch_address;
    data['brch_city'] = this.brch_city;
    data['brch_state'] = this.brch_state;
    data['brch_country'] = this.brch_country;
    data['brch_phone'] = this.brch_phone;
    data['brch_mobile'] = this.brch_mobile;
    return data;
  }
}