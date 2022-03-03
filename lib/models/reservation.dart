import 'package:i_padeel/models/courts.dart';
import 'package:i_padeel/models/location.dart';
import 'package:i_padeel/models/user.dart';
import 'package:intl/intl.dart';

class Reservation {
  late final String guid;
  late final String fromTime;
  late final String toTime;
  late final String date;
  late final User user;
  late final String status;
  late final String mobile;
  late final int channel;
  late final Null paymentMethod;
  late final int cost;
  late final Details details;
  late final Location location;
  late final bool cancancel;

  Reservation.fromJson(Map<String, dynamic> json) {
    guid = json['guid'];
    fromTime = getTime(json['from_time']);
    toTime = getTime(json['to_time']);
    date = getDate(json['from_time']);
    user = User.fromJson(json['user']);
    status = json['status'];
    mobile = json['mobile'];
    channel = json['channel'];
    paymentMethod = json['payment_method'];
    cost = json['cost'];
    details = Details.fromJson(json['details']);
    location = Location.fromJson(json['location']);
    cancancel = json['cancancel'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['guid'] = guid;
    _data['from_time'] = fromTime;
    _data['to_time'] = toTime;
    _data['user'] = user.toJson();
    _data['status'] = status;
    _data['mobile'] = mobile;
    _data['channel'] = channel;
    _data['payment_method'] = paymentMethod;
    _data['cost'] = cost;
    _data['cancancel'] = cancancel;
    _data['details'] = details.toJson();
    _data['location'] = location.toJson();
    return _data;
  }

  String getTime(String time) {
    DateTime dateTime = DateTime.parse(time.substring(0, time.indexOf('+')));
    String myTime = DateFormat('hh:mm a').format(dateTime);
    return myTime;
  }

  String getDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    DateFormat dateFormat = DateFormat.yMMMd();
    return dateFormat.format(dateTime);
  }
}

class Details {
  Details({
    required this.court,
  });
  late final Court court;

  Details.fromJson(Map<String, dynamic> json) {
    court = Court.fromJson(json['court']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['court'] = court.toJson();
    return _data;
  }
}

class Court {
  Court({
    required this.guid,
    required this.name,
  });
  late final String guid;
  late final String name;

  Court.fromJson(Map<String, dynamic> json) {
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

class District {
  District({
    required this.name,
    required this.city,
    required this.id,
  });
  late final String name;
  late final City city;
  late final int id;

  District.fromJson(Map<String, dynamic> json) {
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

class City {
  City({
    required this.id,
    required this.name,
  });
  late final int id;
  late final String name;

  City.fromJson(Map<String, dynamic> json) {
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

class Timeslots {
  Timeslots({
    required this.workingHoursFrom,
    required this.workingHoursTo,
    required this.day,
    required this.interval,
  });
  late final String workingHoursFrom;
  late final String workingHoursTo;
  late final Day day;
  late final int interval;

  Timeslots.fromJson(Map<String, dynamic> json) {
    workingHoursFrom = json['working_hours_from'];
    workingHoursTo = json['working_hours_to'];
    day = Day.fromJson(json['day']);
    interval = json['interval'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['working_hours_from'] = workingHoursFrom;
    _data['working_hours_to'] = workingHoursTo;
    _data['day'] = day.toJson();
    _data['interval'] = interval;
    return _data;
  }
}

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
