class Ratings {
  Ratings({
    required this.id,
    required this.name,
    required this.division,
  });
  int? id;
  String? name;
  Division? division;
  String? description;

  Ratings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    division = Division.fromJson(json['division']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    if (division != null) _data['division'] = division!.toJson();
    _data['description'] = description;
    return _data;
  }
}

class Division {
  Division({
    required this.id,
    required this.name,
  });
  int? id;
  String? name;

  Division.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}
