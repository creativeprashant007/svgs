class ProductAddToCartResponse {
  String success;
  String message;
  String count_cart;

  ProductAddToCartResponse({
    this.success,
    this.message,
    this.count_cart,
  });

  ProductAddToCartResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'].toString();
    message = json['message'];
    count_cart = json['count_cart'].toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['message'] = this.message;
    data['success'] = this.success;
    data['count_cart'] = this.count_cart;

    return data;
  }
}
