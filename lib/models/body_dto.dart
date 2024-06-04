class BodyDTO{
  dynamic body;
  BodyDTO.fromJson(Map<String, dynamic> json):
    this.body = json["body"];
}