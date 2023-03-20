import 'package:cloud_firestore/cloud_firestore.dart';

class Station {
  String id = "";
  String name = "";
  String services = "";
  String phone = "";
  String type = "";
  int cost = 0;
  int count = 0;
  GeoPoint location = GeoPoint(0, 0);

  Station.empty() {}

  Station.name(this.id, this.name, this.type, this.services, this.phone,
      this.cost, this.location);

  Station(this.name, this.services, this.phone, this.type, this.cost,
      this.location);

  Station.fromMap(Map<String, dynamic> map)
      : id = map["id"] ?? "",
        name = map["name"] ?? "",
        type = map["type"] ?? "",
        services = map["services"] ?? "",
        phone = map["phone"] ?? "",
        cost = map["cost"] ?? 0,
        count = map["count"] ?? 0,
        location = map["location"] ?? GeoPoint(0, 0);

  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['type'] = type;
    data['services'] = services;
    data['phone'] = phone;
    data['cost'] = cost;
    data['count'] = count;
    data['location'] = location;
    return data;
  }
}
