import 'package:intl/intl.dart';

class User {
  late final int id;
  late final String firstName;
  late final String lastName;
  late final String email;
  late final String phone;
  late final String photo;
  late final String dateOfBirth;
  late final String gender;
  late final bool isVerified;
  late final int noOfRes;
  late final String rating;

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    photo = json['photo'];
    dateOfBirth = convertDateFormat(json['date_of_birth']);
    gender = json['gender'];
    isVerified = json['is_verified'];
    noOfRes = json['no_of_res'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['email'] = email;
    _data['phone'] = phone;
    _data['photo'] = photo;
    _data['date_of_birth'] = dateOfBirth;
    _data['gender'] = gender;
    _data['is_verified'] = isVerified;
    _data['no_of_res'] = noOfRes;
    _data['rating'] = rating;
    return _data;
  }
}

String convertDateFormat(String listDate) {
  DateTime dateTime = DateTime.parse(listDate);
  DateFormat dateFormat = DateFormat.yMMMd();
  return dateFormat.format(dateTime);
}
