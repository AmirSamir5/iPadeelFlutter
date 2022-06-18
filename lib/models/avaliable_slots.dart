import 'package:i_padeel/models/courts.dart';

class AvailableSlots {
  AvailableSlots({
    required this.name,
    required this.guid,
    required this.slots,
  });
  late final String name;
  late final String guid;
  late final List<Slots> slots;

  AvailableSlots.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    guid = json['guid'];
    slots = List.from(json['slots']).map((e) => Slots.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['guid'] = guid;
    _data['slots'] = slots.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Slots {
  Slots({
    required this.fromTime,
    required this.toTime,
  });
  late final String fromTime;
  late final String toTime;

  Slots.fromJson(Map<String, dynamic> json) {
    fromTime = json['from_time'];
    toTime = json['to_time'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['from'] = fromTime;
    _data['to'] = toTime;
    return _data;
  }
}
