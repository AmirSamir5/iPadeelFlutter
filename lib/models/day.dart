class Day {
  Day({
    required this.id,
    required this.number,
    required this.name,
    required this.iso,
  });
  late final int id;
  late final int number;
  late final String name;
  late final String iso;

  Day.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    number = json['number'];
    name = json['name'];
    iso = json['iso'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['number'] = number;
    _data['name'] = name;
    _data['iso'] = iso;
    return _data;
  }
}
