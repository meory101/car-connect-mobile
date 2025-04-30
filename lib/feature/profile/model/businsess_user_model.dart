import 'dart:convert';
/// user : {"id":1,"phone":"0991338394","name":"bbbb","desc":"bbbbb","lat":33.5050694,"long":36.2607741,"type":null,"idImageUrl":"Jai34BIVeIXK9l9ZPm6YqxcxQgik88jwMvzdAtgZ.jpg","commercialRegisterImageUrl":"VuikvHLk63xMg6TlYXSaWJBuvxakQs1mO57DEPOT.jpg","created_at":"2025-04-13T14:06:34.000000Z","updated_at":"2025-04-13T14:28:48.000000Z"}

BusinsessUserModel businsessUserModelFromJson(String str) => BusinsessUserModel.fromJson(json.decode(str));
String businsessUserModelToJson(BusinsessUserModel data) => json.encode(data.toJson());
class BusinsessUserModel {
  BusinsessUserModel({
      User? user,}){
    _user = user;
}

  BusinsessUserModel.fromJson(dynamic json) {
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  User? _user;
BusinsessUserModel copyWith({  User? user,
}) => BusinsessUserModel(  user: user ?? _user,
);
  User? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }

}

/// id : 1
/// phone : "0991338394"
/// name : "bbbb"
/// desc : "bbbbb"
/// lat : 33.5050694
/// long : 36.2607741
/// type : null
/// idImageUrl : "Jai34BIVeIXK9l9ZPm6YqxcxQgik88jwMvzdAtgZ.jpg"
/// commercialRegisterImageUrl : "VuikvHLk63xMg6TlYXSaWJBuvxakQs1mO57DEPOT.jpg"
/// created_at : "2025-04-13T14:06:34.000000Z"
/// updated_at : "2025-04-13T14:28:48.000000Z"

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());
class User {
  User({
      num? id, 
      String? phone, 
      String? name, 
      String? desc, 
      num? lat, 
      num? long, 
      dynamic type, 
      String? idImageUrl, 
      String? commercialRegisterImageUrl, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _phone = phone;
    _name = name;
    _desc = desc;
    _lat = lat;
    _long = long;
    _type = type;
    _idImageUrl = idImageUrl;
    _commercialRegisterImageUrl = commercialRegisterImageUrl;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  User.fromJson(dynamic json) {
    _id = json['id'];
    _phone = json['phone'];
    _name = json['name'];
    _desc = json['desc'];
    _lat = json['lat'];
    _long = json['long'];
    _type = json['type'];
    _idImageUrl = json['idImageUrl'];
    _commercialRegisterImageUrl = json['commercialRegisterImageUrl'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _phone;
  String? _name;
  String? _desc;
  num? _lat;
  num? _long;
  dynamic _type;
  String? _idImageUrl;
  String? _commercialRegisterImageUrl;
  String? _createdAt;
  String? _updatedAt;
User copyWith({  num? id,
  String? phone,
  String? name,
  String? desc,
  num? lat,
  num? long,
  dynamic type,
  String? idImageUrl,
  String? commercialRegisterImageUrl,
  String? createdAt,
  String? updatedAt,
}) => User(  id: id ?? _id,
  phone: phone ?? _phone,
  name: name ?? _name,
  desc: desc ?? _desc,
  lat: lat ?? _lat,
  long: long ?? _long,
  type: type ?? _type,
  idImageUrl: idImageUrl ?? _idImageUrl,
  commercialRegisterImageUrl: commercialRegisterImageUrl ?? _commercialRegisterImageUrl,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get id => _id;
  String? get phone => _phone;
  String? get name => _name;
  String? get desc => _desc;
  num? get lat => _lat;
  num? get long => _long;
  dynamic get type => _type;
  String? get idImageUrl => _idImageUrl;
  String? get commercialRegisterImageUrl => _commercialRegisterImageUrl;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['phone'] = _phone;
    map['name'] = _name;
    map['desc'] = _desc;
    map['lat'] = _lat;
    map['long'] = _long;
    map['type'] = _type;
    map['idImageUrl'] = _idImageUrl;
    map['commercialRegisterImageUrl'] = _commercialRegisterImageUrl;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}