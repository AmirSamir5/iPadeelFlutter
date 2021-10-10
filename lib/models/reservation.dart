import 'package:i_padeel/models/user.dart';
import 'package:intl/intl.dart';

class Reservation {
  Reservation({
    required this.guid,
    required this.fromTime,
    required this.toTime,
    required this.user,
    required this.status,
    required this.mobile,
    required this.channel,
    this.paymentMethod,
    required this.cost,
    required this.details,
    required this.location,
  });
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
    _data['details'] = details.toJson();
    _data['location'] = location.toJson();
    return _data;
  }

  String getTime(String time) {
    DateTime dateTime = DateTime.parse(time);
    DateFormat dateFormat = DateFormat.Hm();
    return dateFormat.format(dateTime);
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

class Location {
  Location({
    required this.guid,
    required this.name,
    required this.district,
    required this.address,
    required this.information,
    this.image,
    required this.slotPrice,
    required this.latitude,
    required this.longitude,
    required this.courts,
    required this.timeslots,
  });
  late final String guid;
  late final String name;
  late final District district;
  late final String address;
  late final String information;
  late final String? image;
  late final int slotPrice;
  late final String latitude;
  late final String longitude;
  late final List<Courts> courts;
  late final List<Timeslots> timeslots;

  Location.fromJson(Map<String, dynamic> json) {
    guid = json['guid'];
    name = json['name'];
    district = District.fromJson(json['district']);
    address = json['address'];
    information = json['information'];
    image = json['image'];
    slotPrice = json['slot_price'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    courts = List.from(json['courts']).map((e) => Courts.fromJson(e)).toList();
    timeslots =
        List.from(json['timeslots']).map((e) => Timeslots.fromJson(e)).toList();
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
    _data['timeslots'] = timeslots.map((e) => e.toJson()).toList();
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

class Courts {
  Courts({
    required this.guid,
    required this.name,
  });
  late final String guid;
  late final String name;

  Courts.fromJson(Map<String, dynamic> json) {
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
