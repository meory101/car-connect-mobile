String _baseUrl = 'http://192.168.132.164:8000/api/';
String imageUrl = 'http://192.168.132.164:8000/storage/';

class ApiGetUrl {
  static String getBrands = '${_baseUrl}getBrands';
  static String getNewestCars = '${_baseUrl}getNewestCars';

}

class ApiPostUrl {
  static String getCarsByBrandId = '${_baseUrl}getCarsByBrandId';
  static String generateOtp = '${_baseUrl}generateOTP';
  static String verifyCode = '${_baseUrl}verifyCode';
  static String getCarDetails = '${_baseUrl}getCarDetails';
  static String uploadUserIdImage = '${_baseUrl}uploadUserIdImage';
  static String addBusinessUserProfileInfo =
      '${_baseUrl}addBusinessUserProfileInfo';
}

class ApiDeleteUrl {}

class ApiPutUrl {}
