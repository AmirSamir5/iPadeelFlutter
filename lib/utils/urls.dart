import 'package:flutter/material.dart';
import 'package:i_padeel/models/location.dart';

class Urls {
  //static String domain = "https://stagingv2.zabatnee.com/api/";

  static String domain = "https://ipadel.noor.net/";
  static String getLocations = domain + "entity/mob/location";
  static String createReservation = domain + "reservation/mob/court";

  static String loginUser() {
    return domain + "o/token/";
  }

  static String registerUser() {
    return domain + "account/register";
  }

  static String refreshToken() {
    return domain + "o/token/";
  }

  static String getUserProfile() {
    return domain + "account/user";
  }

  static String editUserProfile() {
    return domain + "account/user";
  }

  static String getReservationsList() {
    return domain + "reservation/mob/court";
  }

  static String getRatings() {
    return domain + "lookup/rating";
  }

  static String getAvaliableSlotsForDay(String locationId) {
    return domain + "entity/location/slots?location=$locationId";
  }
}
