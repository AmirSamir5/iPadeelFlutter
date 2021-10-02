
class Courts {
  Courts({
    required this.guid,
    required this.name,
  });
  late final String guid;
  late final String name;
  
  Courts.fromJson(Map<String, dynamic> json){
    guid = json['guid'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['guid'] = guid;
    _data['name'] = name;
    return _data;
  }
}
