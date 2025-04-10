import 'dart:convert';
/// code : 929780
/// updated_at : "2025-04-10T10:44:34.000000Z"
/// created_at : "2025-04-10T10:44:34.000000Z"
/// id : 1

GenerateOtpResponseEntity generateOtpResponseEntityFromJson(String str) => GenerateOtpResponseEntity.fromJson(json.decode(str));
String generateOtpResponseEntityToJson(GenerateOtpResponseEntity data) => json.encode(data.toJson());
class GenerateOtpResponseEntity {
  GenerateOtpResponseEntity({
      num? code, 
      String? updatedAt, 
      String? createdAt, 
      num? id,}){
    _code = code;
    _updatedAt = updatedAt;
    _createdAt = createdAt;
    _id = id;
}

  GenerateOtpResponseEntity.fromJson(dynamic json) {
    _code = json['code'];
    _updatedAt = json['updated_at'];
    _createdAt = json['created_at'];
    _id = json['id'];
  }
  num? _code;
  String? _updatedAt;
  String? _createdAt;
  num? _id;
GenerateOtpResponseEntity copyWith({  num? code,
  String? updatedAt,
  String? createdAt,
  num? id,
}) => GenerateOtpResponseEntity(  code: code ?? _code,
  updatedAt: updatedAt ?? _updatedAt,
  createdAt: createdAt ?? _createdAt,
  id: id ?? _id,
);
  num? get code => _code;
  String? get updatedAt => _updatedAt;
  String? get createdAt => _createdAt;
  num? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['updated_at'] = _updatedAt;
    map['created_at'] = _createdAt;
    map['id'] = _id;
    return map;
  }

}