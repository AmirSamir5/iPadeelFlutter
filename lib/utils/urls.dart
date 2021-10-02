class Urls {
  //static String domain = "https://stagingv2.zabatnee.com/api/";

  static String domain = "https://ipadel.noor.net/";

  static String loginUser() {
    return domain + "o/token/";
  }

  static String getReservationsList() {
    return domain + "reservation/mob/court";
  }
}
