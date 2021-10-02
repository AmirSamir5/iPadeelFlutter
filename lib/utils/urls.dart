import 'package:flutter/material.dart';
import 'package:i_padeel/models/location.dart';

class Urls {
  //static String domain = "https://stagingv2.zabatnee.com/api/";

  static String domain = "https://ipadel.noor.net/";
  static String getLocations = domain + "entity/mob/location";

  static String loginUser() {
    return domain + "o/token/";
  }

  static String getReservationsList() {
    return domain + "reservation/mob/court";
  }

  static String getAvaliableSlotsForDay(String locationId) {
    return domain + "entity/location/slots?location=$locationId";
  }
}
