class Constant {
  static String prefsUserIsVerifiedKey = 'isUserVerified';
  static String prefsUserKey = 'userKey';
  static String prefsUserMobileKey = 'userMobile';
  static String prefsUserAccessTokenKey = 'userAccessToken';
  static String prefsUserRefreshTokenKey = 'userRefreshToken';
  static String prefsTokenExpirationDateKey = 'userExpirationDate';
  static String prefsUserFBTokenKey = 'userFBToken';
  static String prefsUsername = 'usernameKey';
  static String prefsPassword = 'passwordKey';
  static String prefsFacebookId = 'facebookIdKey';

  static Map<String, String> payfortHeader = {
    "content-type": "application/json"
  };
  static String productionMerchantIdentifier = "QKUauJjt";
  static String productionAccessCode = "r6Fhznnp7ZICbjdr4OYo";
  static String productionSHA_Type = "SHA-512";
  static String productionSha_RequestPhrase = "Twaw5bcL7UFkrdja";
  static String productionShe_ResponsePhrase = "LeX6dFpUhC6baH2y";
  static String productionPayfortUrl = "https://payfort.noor.net/payfort/pay/";

  static String stagingMerchantIdentifier = "UqjcHNnt";
  static String stagingAccessCode = "KBcQZMygfNNvT41ihP0F";
  static String stagingSHA_Type = "SHA-256";
  static String stagingSha_RequestPhrase = "xwwqtr454545";
  static String stagingShe_ResponsePhrase = "ytyyuyu654545";
  static String stagingPayfortUrl =
      "https://sbpaymentservices.payfort.com/FortAPI/paymentApi";

  static String paymentCommandAuthroization = "AUTHORIZATION";

  static String paymentCommandPurchase = "PURCHASE";

  static String productionPayfortRefundUrl =
      "https://paymentservices.payfort.com/FortAPI/paymentApi";

  //production
  // static String clientId = 'qQwGRDtrG1VrYl22wIg1Ig4q3hSIpYHxgvodhByI';
  // static String clientSecret =
  //     'LRQ3MpxgI3tSLI8P7yg7kJntKL2Iv0WT17JiJmGH10AL7fOs9fG7ZWWcbpB1wnDneznbbcdEUsAnAIDoJnzZhpLXPDWiG8xour3q1ukMpW3wfcdPqSGTivqx3zrfL1XF';

  //staging
  static String clientId = 'JL8yNMD1hAoTpkx76uee1ZprFDPVxDDK4OboiiVQ';
  static String clientSecret =
      'PiLPPI7cAGATNB3p37D94ssmsKGlB0WktG6u5DAGALy6JysOVi9Knmq6ZmkoQjrRAcJCBuN63I0dsDgp3QSZlJSCwiOfN9AHkvQNC1fNt7lbpqvd6vF7SKHa18ygq8J7';
}
