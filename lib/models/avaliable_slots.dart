import 'package:i_padeel/models/courts.dart';

class AvailableSlots {
  AvailableSlots({
    required this.slotdate,
    required this.slots,
  });
  late final String slotdate;
  late final List<Slots> slots;
  
  AvailableSlots.fromJson(Map<String, dynamic> json){
    slotdate = json['slotdate'];
    slots = List.from(json['slots']).map((e)=>Slots.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['slotdate'] = slotdate;
    _data['slots'] = slots.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Slots {
  Slots({
    required this.fromTime,
    required this.toTime,
    required this.courts,
  });
  late final String fromTime;
  late final String toTime;
  late final List<Courts> courts;
  
  Slots.fromJson(Map<String, dynamic> json){
    fromTime = json['from_time'];
    toTime = json['to_time'];
    courts = List.from(json['courts']).map((e)=>Courts.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['from_time'] = fromTime;
    _data['to_time'] = toTime;
    _data['courts'] = courts.map((e)=>e.toJson()).toList();
    return _data;
  }
}
