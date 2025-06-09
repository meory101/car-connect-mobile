import 'dart:convert';

/// cars : [{"car":{"id":4,"desc":"sssssssssssssssssssssss","price":"222","available":1,"killo":"33","ownerShipImageUrl":"Af17HtkdfJgznhieFK0oXYarpFFRLTQSlgWFOrYR.jpg","colorId":1,"gearId":1,"brandId":1,"modelId":1,"userId":4,"created_at":"2025-04-13T11:29:53.000000Z","updated_at":"2025-04-13T11:29:53.000000Z"},"images":[{"id":1,"imageUrl":"L9idfJOW0K2oChBwRKxmLCGijnJzYXZ9iOH4hJDd.jpg","carId":4,"created_at":"2025-04-13T11:29:53.000000Z","updated_at":"2025-04-13T11:29:53.000000Z"}]},{"car":{"id":5,"desc":"sssssssssssssssssssssss","price":"222","available":1,"killo":"33","ownerShipImageUrl":"7IZMN0h4smEV5HvaDo8Ijqkuzwzd5njQxCAUrx85.jpg","colorId":1,"gearId":1,"brandId":1,"modelId":1,"userId":4,"created_at":"2025-04-13T11:30:28.000000Z","updated_at":"2025-04-13T11:30:28.000000Z"},"images":[{"id":2,"imageUrl":"yKTzR75bMsh2JBXeGphN5lPWDMCpPHnmk4pk1VTh.jpg","carId":5,"created_at":"2025-04-13T11:30:28.000000Z","updated_at":"2025-04-13T11:30:28.000000Z"},{"id":3,"imageUrl":"ElcdyschI6Gt95N2OOVXIciAodumsOiacQYhjsqU.jpg","carId":5,"created_at":"2025-04-13T11:30:28.000000Z","updated_at":"2025-04-13T11:30:28.000000Z"}]},{"car":{"id":6,"desc":"sssssssssssssssssssssss","price":"222","available":1,"killo":"33","ownerShipImageUrl":"qsoOG4YiMl8bop42Vv2xXSwzWafmuTw2P9idYI4p.jpg","colorId":1,"gearId":1,"brandId":1,"modelId":1,"userId":4,"created_at":"2025-04-13T11:30:51.000000Z","updated_at":"2025-04-13T11:30:51.000000Z"},"images":[]},{"car":{"id":7,"desc":"sssssssssssssssssssssss","price":"222","available":1,"killo":"33","ownerShipImageUrl":"L7lzqgHYbhwzqyz3bgBJg9yQgui2sMh2mpT5MABW.jpg","colorId":1,"gearId":1,"brandId":1,"modelId":1,"userId":4,"created_at":"2025-04-13T11:30:59.000000Z","updated_at":"2025-04-13T11:30:59.000000Z"},"images":[{"id":4,"imageUrl":"oc6jPSdYWELDSoRRm5pukp4aJqd1w2IsaugZk5fa.jpg","carId":7,"created_at":"2025-04-13T11:30:59.000000Z","updated_at":"2025-04-13T11:30:59.000000Z"},{"id":5,"imageUrl":"5AP0QuFgrXpFOtlUeM6Vz5zd3VhdveziYEOzLgyk.jpg","carId":7,"created_at":"2025-04-13T11:30:59.000000Z","updated_at":"2025-04-13T11:30:59.000000Z"}]},{"car":{"id":8,"desc":"sssssssssssssssssssssss","price":"222","available":1,"killo":"33","ownerShipImageUrl":"BaenSJBKzfEaFquWx26rxDwcWLjuVgDbyYPupfou.jpg","colorId":1,"gearId":1,"brandId":1,"modelId":1,"userId":4,"created_at":"2025-04-13T11:31:25.000000Z","updated_at":"2025-04-13T11:31:25.000000Z"},"images":[{"id":6,"imageUrl":"JHpxlwV9Jcjm0oPo8Om1Zm8ifPhlcrlD1sz00bXd.jpg","carId":8,"created_at":"2025-04-13T11:31:25.000000Z","updated_at":"2025-04-13T11:31:25.000000Z"},{"id":7,"imageUrl":"lrpjklmY3s9lhE1DpzEuKVHd8U1PM6rNVDz6bSoP.jpg","carId":8,"created_at":"2025-04-13T11:31:25.000000Z","updated_at":"2025-04-13T11:31:25.000000Z"}]}]

CarResponseEntity carResponseEntityFromJson(String str) =>
    CarResponseEntity.fromJson(json.decode(str));
String carResponseEntityToJson(CarResponseEntity data) =>
    json.encode(data.toJson());

class CarResponseEntity {
  CarResponseEntity({
    List<Cars>? cars,
  }) {
    _cars = cars;
  }

  CarResponseEntity.fromJson(dynamic json) {
    if (json['cars'] != null) {
      _cars = [];
      json['cars'].forEach((v) {
        _cars?.add(Cars.fromJson(v));
      });
    }
  }
  List<Cars>? _cars;
  CarResponseEntity copyWith({
    List<Cars>? cars,
  }) =>
      CarResponseEntity(
        cars: cars ?? _cars,
      );
  List<Cars>? get cars => _cars;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_cars != null) {
      map['cars'] = _cars?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// car : {"id":4,"desc":"sssssssssssssssssssssss","price":"222","available":1,"killo":"33","ownerShipImageUrl":"Af17HtkdfJgznhieFK0oXYarpFFRLTQSlgWFOrYR.jpg","colorId":1,"gearId":1,"brandId":1,"modelId":1,"userId":4,"created_at":"2025-04-13T11:29:53.000000Z","updated_at":"2025-04-13T11:29:53.000000Z"}
/// images : [{"id":1,"imageUrl":"L9idfJOW0K2oChBwRKxmLCGijnJzYXZ9iOH4hJDd.jpg","carId":4,"created_at":"2025-04-13T11:29:53.000000Z","updated_at":"2025-04-13T11:29:53.000000Z"}]

Cars carsFromJson(String str) => Cars.fromJson(json.decode(str));
String carsToJson(Cars data) => json.encode(data.toJson());

class Cars {
  Cars({
    Car? car,
    List<Images>? images,
  }) {
    _car = car;
    _images = images;
  }

  Cars.fromJson(dynamic json) {
    _car = json['car'] != null ? Car.fromJson(json['car']) : null;
    if (json['images'] != null) {
      _images = [];
      json['images'].forEach((v) {
        _images?.add(Images.fromJson(v));
      });
    }
  }
  Car? _car;
  List<Images>? _images;
  Cars copyWith({
    Car? car,
    List<Images>? images,
  }) =>
      Cars(
        car: car ?? _car,
        images: images ?? _images,
      );
  Car? get car => _car;
  List<Images>? get images => _images;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_car != null) {
      map['car'] = _car?.toJson();
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
    String? updatedAt,
  }) {
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
  Images copyWith({
    num? id,
    String? imageUrl,
    num? carId,
    String? createdAt,
    String? updatedAt,
  }) =>
      Images(
        id: id ?? _id,
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
    num? rent,
    String? killo,
    String? ownerShipImageUrl,
    num? colorId,
    num? gearId,
    num? brandId,
    num? modelId,
    num? userId,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _desc = desc;
    _price = price;
    _available = available;
    _rent = rent;
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
    _rent = json['rent'];
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
  num? _rent;
  String? _killo;
  String? _ownerShipImageUrl;
  num? _colorId;
  num? _gearId;
  num? _brandId;
  num? _modelId;
  num? _userId;
  String? _createdAt;
  String? _updatedAt;
  Car copyWith({
    num? id,
    String? desc,
    String? price,
    num? available,
    num? rent,
    String? killo,
    String? ownerShipImageUrl,
    num? colorId,
    num? gearId,
    num? brandId,
    num? modelId,
    num? userId,
    String? createdAt,
    String? updatedAt,
  }) =>
      Car(
        id: id ?? _id,
        desc: desc ?? _desc,
        price: price ?? _price,
        available: available ?? _available,
        rent: rent ?? _rent,
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
  num? get rent => _rent;
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
    map['rent'] = _rent;
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
