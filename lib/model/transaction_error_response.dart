class TransactionErrorResponse {
  TransactionError error;

  TransactionErrorResponse({
    this.error,
  });
  TransactionErrorResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'] != null
        ? new TransactionError.fromJson(json['error'])
        : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.error != null) {
      data['error'] = this.error.toJson();
    }

    return data;
  }
}

class TransactionError {
  String code;
  String description;
  String source;
  String step;
  String reason;

  TransactionError(
      {this.code, this.description, this.source, this.step, this.reason});
  TransactionError.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    description = json['description'];
    source = json['source'];
    step = json['step'];
    reason = json['step'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['description'] = this.description;
    data['source'] = this.source;
    data['step'] = this.step;
    data['reason'] = this.reason;

    return data;
  }
}
