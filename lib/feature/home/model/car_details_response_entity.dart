import 'dart:convert';

import 'comments.dart';
/// car : {"id":4,"desc":"sssssssssssssssssssssss","price":"222","available":1,"killo":"33","ownerShipImageUrl":"Af17HtkdfJgznhieFK0oXYarpFFRLTQSlgWFOrYR.jpg","colorId":1,"gearId":1,"brandId":1,"modelId":1,"userId":4,"created_at":"2025-04-13T11:29:53.000000Z","updated_at":"2025-04-13T11:29:53.000000Z"}
/// gear : {"id":1,"name":"rrrrrr","created_at":null,"updated_at":null}
/// model : {"id":1,"name":"model","created_at":"2025-04-10T12:44:00.000000Z","updated_at":"2025-04-10T12:44:00.000000Z"}
/// color : {"id":1,"name":"5555","created_at":null,"updated_at":null}
/// brand : {"id":1,"name":"BMW","created_at":"2025-04-10T11:53:50.000000Z","updated_at":"2025-04-10T11:53:50.000000Z"}
/// images : [{"id":1,"imageUrl":"L9idfJOW0K2oChBwRKxmLCGijnJzYXZ9iOH4hJDd.jpg","carId":4,"created_at":"2025-04-13T11:29:53.000000Z","updated_at":"2025-04-13T11:29:53.000000Z"}]

CarDetailsResponseEntity carDetailsResponseEntityFromJson(String str) => CarDetailsResponseEntity.fromJson(json.decode(str));
String carDetailsResponseEntityToJson(CarDetailsResponseEntity data) => json.encode(data.toJson());
class CarDetailsResponseEntity {
  CarDetailsResponseEntity({
      Car? car, 
      Gear? gear, 
      Model? model, 
      Color? color, 
      Brand? brand,
      String? rate,
      String? views,
      String? likes,

    List<Comments>? comments,
      List<Images>? images,}){
    _car = car;
    _likes = likes;
    _comments =comments;
    _gear = gear;
    _model = model;
    _color = color;
    _rate = rate;
    _views = views;
    _brand = brand;
    _images = images;
}

  CarDetailsResponseEntity.fromJson(dynamic json) {
    _comments = json['comments'] == null
        ? []
        : List<Comments>.from(json['comments'].map((x) => Comments.fromJson(x)));
    _car = json['car'] != null ? Car.fromJson(json['car']) : null;
    _rate = json['rate']?.toString();
    _views = json['views'].toString();
    _likes = json['likes'].toString();
    _gear = json['gear'] != null ? Gear.fromJson(json['gear']) : null;
    _model = json['model'] != null ? Model.fromJson(json['model']) : null;
    _color = json['color'] != null ? Color.fromJson(json['color']) : null;
    _brand = json['brand'] != null ? Brand.fromJson(json['brand']) : null;
    if (json['images'] != null) {
      _images = [];
      json['images'].forEach((v) {
        _images?.add(Images.fromJson(v));
      });
    }
  }
  Car? _car;
  Gear? _gear;
  Model? _model;
  Color? _color;
  String? _rate;
  String? _views;
  String? _likes;
  Brand? _brand;
  List<Comments>? _comments;
  List<Images>? _images;
CarDetailsResponseEntity copyWith({  Car? car,
  Gear? gear,
  Model? model,
  List<Comments>? comments,
  Color? color,
  Brand? brand,
  List<Images>? images,
  String? rate,
  String? likes,
  String? views
}) => CarDetailsResponseEntity(  car: car ?? _car,
  gear: gear ?? _gear,
  comments: comments ?? _comments,
  model: model ?? _model,
  color: color ?? _color,
  brand: brand ?? _brand,
  images: images ?? _images,
  likes: likes ?? _likes,
  views: views?? _views,
  rate:rate?? _rate
);
  Car? get car => _car;
  String? get rate => _rate;
  String? get views => _views;
  String? get likes => _likes;
  Gear? get gear => _gear;
  Model? get model => _model;
  Color? get color => _color;
  Brand? get brand => _brand;
  List<Comments>? get comments => _comments;
  List<Images>? get images => _images;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_car != null) {
      map['car'] = _car?.toJson();
    }
    if (_gear != null) {
      map['gear'] = _gear?.toJson();
    }
    if (_model != null) {
      map['model'] = _model?.toJson();
    }
    if (_color != null) {
      map['color'] = _color?.toJson();
    }
    if (_brand != null) {
      map['brand'] = _brand?.toJson();
    }
    if (_images != null) {
      map['images'] = _images?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// imageUrl : "L9idfJOW0K2oChBwRKxmLCGijnJzYXZ9iOH4hJDd.jpg"
/// carId : 4
/// created_at : "2025-04-13T11:29:53.000000Z"
/// updated_at : "2025-04-13T11:29:53.000000Z"

Images imagesFromJson(String str) => Images.fromJson(json.decode(str));
String imagesToJson(Images data) => json.encode(data.toJson());
class Images {
  Images({
      num? id, 
      String? imageUrl, 
      num? carId, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _imageUrl = imageUrl;
    _carId = carId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Images.fromJson(dynamic json) {
    _id = json['id'];
    _imageUrl = json['imageUrl'];
    _carId = json['carId'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _imageUrl;
  num? _carId;
  String? _createdAt;
  String? _updatedAt;
Images copyWith({  num? id,
  String? imageUrl,
  num? carId,
  String? createdAt,
  String? updatedAt,
}) => Images(  id: id ?? _id,
  imageUrl: imageUrl ?? _imageUrl,
  carId: carId ?? _carId,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get id => _id;
  String? get imageUrl => _imageUrl;
  num? get carId => _carId;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['imageUrl'] = _imageUrl;
    map['carId'] = _carId;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}

/// id : 1
/// name : "BMW"
/// created_at : "2025-04-10T11:53:50.000000Z"
/// updated_at : "2025-04-10T11:53:50.000000Z"

Brand brandFromJson(String str) => Brand.fromJson(json.decode(str));
String brandToJson(Brand data) => json.encode(data.toJson());
class Brand {
  Brand({
      num? id, 
      String? name, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _name = name;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Brand.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _name;
  String? _createdAt;
  String? _updatedAt;
Brand copyWith({  num? id,
  String? name,
  String? createdAt,
  String? updatedAt,
}) => Brand(  id: id ?? _id,
  name: name ?? _name,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get id => _id;
  String? get name => _name;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}

/// id : 1
/// name : "5555"
/// created_at : null
/// updated_at : null

Color colorFromJson(String str) => Color.fromJson(json.decode(str));
String colorToJson(Color data) => json.encode(data.toJson());
class Color {
  Color({
      num? id, 
      String? name, 
      dynamic createdAt, 
      dynamic updatedAt,}){
    _id = id;
    _name = name;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Color.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _name;
  dynamic _createdAt;
  dynamic _updatedAt;
Color copyWith({  num? id,
  String? name,
  dynamic createdAt,
  dynamic updatedAt,
}) => Color(  id: id ?? _id,
  name: name ?? _name,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get id => _id;
  String? get name => _name;
  dynamic get createdAt => _createdAt;
  dynamic get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}

/// id : 1
/// name : "model"
/// created_at : "2025-04-10T12:44:00.000000Z"
/// updated_at : "2025-04-10T12:44:00.000000Z"

Model modelFromJson(String str) => Model.fromJson(json.decode(str));
String modelToJson(Model data) => json.encode(data.toJson());
class Model {
  Model({
      num? id, 
      String? name, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _name = name;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Model.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _name;
  String? _createdAt;
  String? _updatedAt;
Model copyWith({  num? id,
  String? name,
  String? createdAt,
  String? updatedAt,
}) => Model(  id: id ?? _id,
  name: name ?? _name,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get id => _id;
  String? get name => _name;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}

/// id : 1
/// name : "rrrrrr"
/// created_at : null
/// updated_at : null

Gear gearFromJson(String str) => Gear.fromJson(json.decode(str));
String gearToJson(Gear data) => json.encode(data.toJson());
class Gear {
  Gear({
      num? id, 
      String? name, 
      dynamic createdAt, 
      dynamic updatedAt,}){
    _id = id;
    _name = name;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Gear.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _name;
  dynamic _createdAt;
  dynamic _updatedAt;
Gear copyWith({  num? id,
  String? name,
  dynamic createdAt,
  dynamic updatedAt,
}) => Gear(  id: id ?? _id,
  name: name ?? _name,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get id => _id;
  String? get name => _name;
  dynamic get createdAt => _createdAt;
  dynamic get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}

/// id : 4
/// desc : "sssssssssssssssssssssss"
/// price : "222"
/// available : 1
/// killo : "33"
/// ownerShipImageUrl : "Af17HtkdfJgznhieFK0oXYarpFFRLTQSlgWFOrYR.jpg"
/// colorId : 1
/// gearId : 1
/// brandId : 1
/// modelId : 1
/// userId : 4
/// created_at : "2025-04-13T11:29:53.000000Z"
/// updated_at : "2025-04-13T11:29:53.000000Z"

Car carFromJson(String str) => Car.fromJson(json.decode(str));
String carToJson(Car data) => json.encode(data.toJson());
class Car {
  Car({
      num? id, 
      String? desc, 
      String? price, 
      num? available, 
      String? killo, 
      String? ownerShipImageUrl, 
      num? colorId, 
      num? gearId, 
      num? brandId, 
      num? modelId, 
      num? userId, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _desc = desc;
    _price = price;
    _available = available;
    _killo = killo;
    _ownerShipImageUrl = ownerShipImageUrl;
    _colorId = colorId;
    _gearId = gearId;
    _brandId = brandId;
    _modelId = modelId;
    _userId = userId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Car.fromJson(dynamic json) {
    _id = json['id'];
    _desc = json['desc'];
    _price = json['price'];
    _available = json['available'];
    _killo = json['killo'];
    _ownerShipImageUrl = json['ownerShipImageUrl'];
    _colorId = json['colorId'];
    _gearId = json['gearId'];
    _brandId = json['brandId'];
    _modelId = json['modelId'];
    _userId = json['userId'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _desc;
  String? _price;
  num? _available;
  String? _killo;
  String? _ownerShipImageUrl;
  num? _colorId;
  num? _gearId;
  num? _brandId;
  num? _modelId;
  num? _userId;
  String? _createdAt;
  String? _updatedAt;
Car copyWith({  num? id,
  String? desc,
  String? price,
  num? available,
  String? killo,
  String? ownerShipImageUrl,
  num? colorId,
  num? gearId,
  num? brandId,
  num? modelId,
  num? userId,
  String? createdAt,
  String? updatedAt,
}) => Car(  id: id ?? _id,
  desc: desc ?? _desc,
  price: price ?? _price,
  available: available ?? _available,
  killo: killo ?? _killo,
  ownerShipImageUrl: ownerShipImageUrl ?? _ownerShipImageUrl,
  colorId: colorId ?? _colorId,
  gearId: gearId ?? _gearId,
  brandId: brandId ?? _brandId,
  modelId: modelId ?? _modelId,
  userId: userId ?? _userId,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get id => _id;
  String? get desc => _desc;
  String? get price => _price;
  num? get available => _available;
  String? get killo => _killo;
  String? get ownerShipImageUrl => _ownerShipImageUrl;
  num? get colorId => _colorId;
  num? get gearId => _gearId;
  num? get brandId => _brandId;
  num? get modelId => _modelId;
  num? get userId => _userId;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['desc'] = _desc;
    map['price'] = _price;
    map['available'] = _available;
    map['killo'] = _killo;
    map['ownerShipImageUrl'] = _ownerShipImageUrl;
    map['colorId'] = _colorId;
    map['gearId'] = _gearId;
    map['brandId'] = _brandId;
    map['modelId'] = _modelId;
    map['userId'] = _userId;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}