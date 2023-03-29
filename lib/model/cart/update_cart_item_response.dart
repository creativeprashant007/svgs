class UpdateCartItemResponse {
  String success;
  String error;

  UpdateCartItemResponse({
    this.success,
    this.error,
  });

  UpdateCartItemResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'].toString();
    error = json['error'].toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['error'] = this.error;
    data['success'] = this.success;

    return data;
  }
}
