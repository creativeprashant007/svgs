class PaymentMethodResponse {
  PaymentMethodResult result;

  PaymentMethodResponse({
    this.result,
  });
  PaymentMethodResponse.fromJson(Map<String, dynamic> json) {
    result = json['result'] != null
        ? PaymentMethodResult.fromJson(json['result'])
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

class PaymentMethodResult {
  String status;
  List<PaymentMethod> payment_methods;

  PaymentMethodResult({
    this.status,
    this.payment_methods,
  });
  PaymentMethodResult.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['payment_methods'] != null) {
      payment_methods = <PaymentMethod>[];
      json['payment_methods'].forEach((v) {
        payment_methods.add(new PaymentMethod.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    return data;
  }
}

class PaymentMethod {
  String method;

  PaymentMethod({
    this.method,
  });

  PaymentMethod.fromJson(Map<String, dynamic> json) {
    method = json['method'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    return data;
  }
}
