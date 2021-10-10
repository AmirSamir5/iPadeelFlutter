import 'package:i_padeel/models/ratings.dart';
import 'package:intl/intl.dart';

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? phone;
  String? photo;
  String? dateOfBirth;
  String? gender;
  bool? isVerified;
  int? noOfRes;
  Ratings? rating;

  User();

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    photo = json['photo'];
    dateOfBirth =
        convertDateFormat(json['date_of_birth']) ?? json['date_of_birth'];
    gender = json['gender'];
    isVerified = json['is_verified'];
    noOfRes = json['no_of_res'];
    rating = Ratings.fromJson(json['rating']);
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

String? convertDateFormat(String? listDate) {
  try {
    if (listDate == null) return null;
    DateTime dateTime = DateTime.parse(listDate);
    DateFormat dateFormat = DateFormat.yMMMd();
    return dateFormat.format(dateTime);
  } catch (_) {
    return null;
  }
}
