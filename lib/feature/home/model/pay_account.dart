import 'dart:convert';
/// id : 1
/// balance : "0"
/// accountNumber : 89183711
/// userId : 1
/// created_at : "2025-04-17T12:07:10.000000Z"
/// updated_at : "2025-04-17T12:07:10.000000Z"

PayAccount payAccountFromJson(String str) => PayAccount.fromJson(json.decode(str));
String payAccountToJson(PayAccount data) => json.encode(data.toJson());
class PayAccount {
  PayAccount({
      num? id, 
      String? balance, 
      num? accountNumber, 
      num? userId, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _balance = balance;
    _accountNumber = accountNumber;
    _userId = userId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  PayAccount.fromJson(dynamic json) {
    _id = json['id'];
    _balance = json['balance'];
    _accountNumber = json['accountNumber'];
    _userId = json['userId'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _balance;
  num? _accountNumber;
  num? _userId;
  String? _createdAt;
  String? _updatedAt;
PayAccount copyWith({  num? id,
  String? balance,
  num? accountNumber,
  num? userId,
  String? createdAt,
  String? updatedAt,
}) => PayAccount(  id: id ?? _id,
  balance: balance ?? _balance,
  accountNumber: accountNumber ?? _accountNumber,
  userId: userId ?? _userId,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get id => _id;
  String? get balance => _balance;
  num? get accountNumber => _accountNumber;
  num? get userId => _userId;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['balance'] = _balance;
    map['accountNumber'] = _accountNumber;
    map['userId'] = _userId;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}