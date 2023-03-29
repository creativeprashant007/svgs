class StaticContentResponse {
  StaticContentData result;

  StaticContentResponse({
    this.result,
  });
  StaticContentResponse.fromJson(Map<String, dynamic> json) {
    result = json['result'] != null
        ? new StaticContentData.fromJson(json['result'])
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

class StaticContentData {
  String status;
  String content;

  StaticContentData({
    this.status,
    this.content,
  });
  StaticContentData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;

    return data;
  }
}
