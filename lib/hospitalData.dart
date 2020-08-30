// To parse this JSON data, do
//
//     final hospitalData = hospitalDataFromJson(jsonString);

import 'dart:convert';

List<HospitalData> hospitalDataFromJson(String str) => List<HospitalData>.from(json.decode(str).map((x) => HospitalData.fromJson(x)));

String hospitalDataToJson(List<HospitalData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HospitalData {
  HospitalData({
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

  factory HospitalData.fromJson(Map<String, dynamic> json) => HospitalData(
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
