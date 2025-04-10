String _baseUrl = 'http://192.168.110.164:8000/api/';
// String imageUrl = 'http://192.168.55.164:8000/storage/';

class ApiGetUrl {
  static String cars = '${_baseUrl}car/list/';
  static String myReservations = '${_baseUrl}car/my-temporary-reservations/';
  static String search = '${_baseUrl}car/serche-customer/';
}

class ApiPostUrl {
  static String login = '${_baseUrl}account/login';
  static String generateOtp = '${_baseUrl}generateOTP';
  static String verifyCode = '${_baseUrl}verifyCode';
  static String addBusinessUserProfileInfo =
      '${_baseUrl}addBusinessUserProfileInfo';
}

class ApiDeleteUrl {}

class ApiPutUrl {}
