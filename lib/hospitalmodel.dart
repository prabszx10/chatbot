// To parse this JSON data, do
//
//     final hospitalmodel = hospitalmodelFromJson(jsonString);

import 'dart:convert';

List<Hospitalmodel> hospitalmodelFromJson(String str) => List<Hospitalmodel>.from(json.decode(str).map((x) => Hospitalmodel.fromJson(x)));

String hospitalmodelToJson(List<Hospitalmodel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Hospitalmodel {
  Hospitalmodel({
    this.name,
    this.address,
    this.region,
    this.phone,
    this.province,
  });

  String name;
  String address;
  String region;
  String phone;
  String province;

  factory Hospitalmodel.fromJson(Map<String, dynamic> json) => Hospitalmodel(
    name: json["name"],
    address: json["address"],
    region: json["region"],
    phone: json["phone"] == null ? null : json["phone"],
    province: json["province"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "address": address,
    "region": region,
    "phone": phone == null ? null : phone,
    "province": province,
  };
}
