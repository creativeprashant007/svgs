class ContactUsResponse {
  ContactUsResult result;

  ContactUsResponse({
    this.result,
  });
  ContactUsResponse.fromJson(Map<String, dynamic> json) {
    result = json['result'] != null
        ? ContactUsResult.fromJson(json['result'])
        : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class ContactUsResult {
  String status;
  List<ContactUsAddress> all_address;

  ContactUsResult({
    this.status,
    this.all_address,
  });
  ContactUsResult.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['all_address'] != null) {
      all_address = <ContactUsAddress>[];
      json['all_address'].forEach((v) {
        all_address.add(new ContactUsAddress.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    return data;
  }
}

class ContactUsAddress {
  String address_name;
  String address;
  String whatsapp_number;

  ContactUsAddress({
    this.address_name,
    this.address,
    this.whatsapp_number,
  });

  ContactUsAddress.fromJson(Map<String, dynamic> json) {
    address_name = json['address_name'];
    address = json['address'];
    whatsapp_number = json['whatsapp_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    return data;
  }
}
