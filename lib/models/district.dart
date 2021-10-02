
import 'package:i_padeel/models/city.dart';

class District {
  District({
    required this.name,
    required this.city,
    required this.id,
  });
  late final String name;
  late final City city;
  late final int id;
  
  District.fromJson(Map<String, dynamic> json){
    name = json['name'];
    city = City.fromJson(json['city']);
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['city'] = city.toJson();
    _data['id'] = id;
    return _data;
  }
}


