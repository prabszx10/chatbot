import 'dart:convert';
import 'hospitalmodel.dart';
import 'package:http/http.dart' as http;

class HospitalViewModel {

  Future<List<Hospitalmodel>> getUsers() async {
    try {
      http.Response hasil = await http.get(
          Uri.encodeFull("https://dekontaminasi.com/api/id/covid19/hospitals"),
          headers: {"Accept": "application/json"});
      if (hasil.statusCode == 200) {
        print("data category success");
        final data = hospitalmodelFromJson(hasil.body);
        return data;
      } else {
        print("error status " + hasil.statusCode.toString());
        return null;
      }
    } catch (e) {
      print("error catch $e");
      return null;
    }
  }
}