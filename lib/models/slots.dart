class Slot {
  String isoFrom;
  String isoTo;
  String fromTime;
  String toTime;
  int seats;

  Slot(
      {required this.isoFrom,
      required this.isoTo,
      required this.fromTime,
      required this.toTime,
      required this.seats});

  Slot.fromJson(Map<String, dynamic> json)
      : isoFrom = json['isoFrom'],
        isoTo = json['isoTo'],
        fromTime = json['from_time'],
        toTime = json['to_time'],
        seats = json['seats'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isoFrom'] = this.isoFrom;
    data['isoTo'] = this.isoTo;
    data['from_time'] = this.fromTime;
    data['to_time'] = this.toTime;
    data['seats'] = this.seats;
    return data;
  }
}
