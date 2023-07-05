// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this, camel_case_types

class infoPoint {
  String? status;
  String? neighbourhood;
  String? municipalityZone;
  String? state;
  String? city;
  bool? inTrafficZone;
  bool? inOddEvenZone;
  String? routeName;
  String? routeType;
  String? place;
  String? district;
  String? formattedAddress;
  String? village;
  String? county;

  infoPoint(
      {this.status,
      this.neighbourhood,
      this.municipalityZone,
      this.state,
      this.city,
      this.inTrafficZone,
      this.inOddEvenZone,
      this.routeName,
      this.routeType,
      this.place,
      this.district,
      this.formattedAddress,
      this.village,
      this.county});

  infoPoint.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    neighbourhood = json['neighbourhood'];
    municipalityZone = json['municipality_zone'];
    state = json['state'];
    city = json['city'];
    inTrafficZone = json['in_traffic_zone'];
    inOddEvenZone = json['in_odd_even_zone'];
    routeName = json['route_name'];
    routeType = json['route_type'];
    place = json['place'];
    district = json['district'];
    formattedAddress = json['formatted_address'];
    village = json['village'];
    county = json['county'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['neighbourhood'] = this.neighbourhood;
    data['municipality_zone'] = this.municipalityZone;
    data['state'] = this.state;
    data['city'] = this.city;
    data['in_traffic_zone'] = this.inTrafficZone;
    data['in_odd_even_zone'] = this.inOddEvenZone;
    data['route_name'] = this.routeName;
    data['route_type'] = this.routeType;
    data['place'] = this.place;
    data['district'] = this.district;
    data['formatted_address'] = this.formattedAddress;
    data['village'] = this.village;
    data['county'] = this.county;
    return data;
  }
}
