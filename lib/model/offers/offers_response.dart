class OffersResponse {
  String message;
  String statusCode;
  List<String> data;

  OffersResponse({this.message, this.statusCode, this.data});

  OffersResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    statusCode = json['statusCode'];
    data = json['data'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['statusCode'] = this.statusCode;
    data['data'] = this.data;
    return data;
  }
}
