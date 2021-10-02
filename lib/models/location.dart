/*
class Autogenerated {
  String code;
  String detail;
  List<Location> location;

  Autogenerated({required this.code,required  this.detail, required this.location});

  Autogenerated.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    detail = json['detail'];
    if (json['location'] != null) {
      location = new List<Location>();
      json['location'].forEach((v) {
        location.add(new Location.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['detail'] = this.detail;
    if (this.location != null) {
      data['location'] = this.location.map((v) => v.toJson()).toList();
    }
    return data;
  }
}*/
import 'package:i_padeel/models/courts.dart';
import 'package:i_padeel/models/district.dart';

class AutoGenerate {
  AutoGenerate({
    required this.code,
    required this.detail,
    required this.location,
  });
  late final String code;
  late final String detail;
  late final List<Location> location;

  AutoGenerate.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    detail = json['detail'];
    location =
        List.from(json['location']).map((e) => Location.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['code'] = code;
    _data['detail'] = detail;
    _data['location'] = location.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Location {
  Location({
    required this.guid,
    required this.name,
    required this.district,
    required this.address,
    required this.information,
    required this.image,
    required this.slotPrice,
    required this.latitude,
    required this.longitude,
    required this.courts,
  });
  final String guid;
  final String name;
  final District district;
  final String address;
  final String information;
  final String? image;
  final int slotPrice;
  final String latitude;
  final String longitude;
  final List<Courts> courts;

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
        guid: json['guid'],
        name: json['name'],
        district: District.fromJson(json['district']),
        address: json['address'],
        information: json['information'],
        image: json['image'],
        slotPrice: json['slot_price'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        courts:
            List.from(json['courts']).map((e) => Courts.fromJson(e)).toList());
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['guid'] = guid;
    _data['name'] = name;
    _data['district'] = district.toJson();
    _data['address'] = address;
    _data['information'] = information;
    _data['image'] = image;
    _data['slot_price'] = slotPrice;
    _data['latitude'] = latitude;
    _data['longitude'] = longitude;
    _data['courts'] = courts.map((e) => e.toJson()).toList();

    return _data;
  }
}
