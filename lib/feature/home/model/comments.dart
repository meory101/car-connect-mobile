import 'dart:convert';
/// id : 1
/// comment : "غغغ"
/// userId : 3
/// carId : 1
/// created_at : "2025-05-11T10:02:48.000000Z"
/// updated_at : "2025-05-11T10:02:48.000000Z"
/// user : {"id":3,"phone":"0688555565","idImageUrl":"EFlsdyd1MZ7IxtmJOTHzClwfKNawzqzOvtIU7YdA.jpg","created_at":"2025-04-30T09:54:23.000000Z","updated_at":"2025-04-30T09:54:45.000000Z"}

Comments commentsFromJson(String str) => Comments.fromJson(json.decode(str));
String commentsToJson(Comments data) => json.encode(data.toJson());
class Comments {
  Comments({
      num? id, 
      String? comment, 
      num? userId, 
      num? carId, 
      String? createdAt, 
      String? updatedAt, 
      User? user,}){
    _id = id;
    _comment = comment;
    _userId = userId;
    _carId = carId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _user = user;
}

  Comments.fromJson(dynamic json) {
    _id = json['id'];
    _comment = json['comment'];
    _userId = json['userId'];
    _carId = json['carId'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    print(json['user']);
    print(_user?.phone);
  }
  num? _id;
  String? _comment;
  num? _userId;
  num? _carId;
  String? _createdAt;
  String? _updatedAt;
  User? _user;
Comments copyWith({  num? id,
  String? comment,
  num? userId,
  num? carId,
  String? createdAt,
  String? updatedAt,
  User? user,
}) => Comments(  id: id ?? _id,
  comment: comment ?? _comment,
  userId: userId ?? _userId,
  carId: carId ?? _carId,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  user: user ?? _user,
);
  num? get id => _id;
  String? get comment => _comment;
  num? get userId => _userId;
  num? get carId => _carId;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  User? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['comment'] = _comment;
    map['userId'] = _userId;
    map['carId'] = _carId;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }

}

/// id : 3
/// phone : "0688555565"
/// idImageUrl : "EFlsdyd1MZ7IxtmJOTHzClwfKNawzqzOvtIU7YdA.jpg"
/// created_at : "2025-04-30T09:54:23.000000Z"
/// updated_at : "2025-04-30T09:54:45.000000Z"

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());
class User {
  User({
      num? id, 
      String? phone, 
      String? idImageUrl, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _phone = phone;
    _idImageUrl = idImageUrl;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  User.fromJson(dynamic json) {
    _id = json['id'];
    _phone = json['phone'];
    _idImageUrl = json['idImageUrl'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _phone;
  String? _idImageUrl;
  String? _createdAt;
  String? _updatedAt;
User copyWith({  num? id,
  String? phone,
  String? idImageUrl,
  String? createdAt,
  String? updatedAt,
}) => User(  id: id ?? _id,
  phone: phone ?? _phone,
  idImageUrl: idImageUrl ?? _idImageUrl,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get id => _id;
  String? get phone => _phone;
  String? get idImageUrl => _idImageUrl;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['phone'] = _phone;
    map['idImageUrl'] = _idImageUrl;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}