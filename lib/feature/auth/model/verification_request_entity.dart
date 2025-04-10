import 'dart:convert';
/// type : 2
/// phone : "0991338394"
/// code : 984625

VerificationRequestEntity verificationRequestEntityFromJson(String str) => VerificationRequestEntity.fromJson(json.decode(str));
String verificationRequestEntityToJson(VerificationRequestEntity data) => json.encode(data.toJson());
class VerificationRequestEntity {
  VerificationRequestEntity({
      String? type, 
      String? phone, 
      String? code,}){
    _type = type;
    _phone = phone;
    _code = code;
}

  VerificationRequestEntity.fromJson(dynamic json) {
    _type = json['type'];
    _phone = json['phone'];
    _code = json['code'];
  }
  String? _type;
  String? _phone;
  String? _code;
VerificationRequestEntity copyWith({  String? type,
  String? phone,
  String? code,
}) => VerificationRequestEntity(  type: type ?? _type,
  phone: phone ?? _phone,
  code: code ?? _code,
);

  set type(String? value) {
    _type = value;
  }

  String? get type => _type;
  String? get phone => _phone;
  String? get code => _code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = _type;
    map['phone'] = _phone;
    map['code'] = _code;
    return map;
  }

  set phone(String? value) {
    _phone = value;
  }

  set code(String? value) {
    _code = value;
  }
}