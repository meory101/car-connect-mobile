import 'dart:convert';
/// type : 2
/// phone : "0991338394"

GenerateOtpRequestEntitiy generateOtpRequestEntitiyFromJson(String str) => GenerateOtpRequestEntitiy.fromJson(json.decode(str));
String generateOtpRequestEntitiyToJson(GenerateOtpRequestEntitiy data) => json.encode(data.toJson());
class GenerateOtpRequestEntitiy {
  GenerateOtpRequestEntitiy({
      String? type, 
      String? phone,}){
    _type = type;
    _phone = phone;
}

  GenerateOtpRequestEntitiy.fromJson(dynamic json) {
    _type = json['type'];
    _phone = json['phone'];
  }
  String? _type;
  String? _phone;
GenerateOtpRequestEntitiy copyWith({  String? type,
  String? phone,
}) => GenerateOtpRequestEntitiy(  type: type ?? _type,
  phone: phone ?? _phone,
);
  String? get type => _type;
  String? get phone => _phone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = _type;
    map['phone'] = _phone;
    return map;
  }

  set phone(String? value) {
    _phone = value;
  }

  set type(String? value) {
    _type = value;
  }
}