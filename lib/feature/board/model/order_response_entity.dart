import 'dart:convert';
/// orders : [{"order":{"id":1,"status":"0","paymentType":"0","date":"ddd","totalPrice":"5237.3666318744","lat":33,"long":22,"userId":1,"deliveryId":null,"carId":12,"created_at":"2025-04-20T05:48:35.000000Z","updated_at":"2025-04-20T05:48:35.000000Z"},"car":{"id":12,"desc":"the changes","price":"200","available":0,"killo":"255","ownerShipImageUrl":null,"colorId":1,"gearId":1,"brandId":1,"modelId":1,"userId":4,"created_at":"2025-04-18T07:36:10.000000Z","updated_at":"2025-04-20T05:48:34.000000Z"}}]

OrderResponseEntity orderResponseEntityFromJson(String str) => OrderResponseEntity.fromJson(json.decode(str));
String orderResponseEntityToJson(OrderResponseEntity data) => json.encode(data.toJson());
class OrderResponseEntity {
  OrderResponseEntity({
      List<Orders>? orders,}){
    _orders = orders;
}

  OrderResponseEntity.fromJson(dynamic json) {
    if (json['orders'] != null) {
      _orders = [];
      json['orders'].forEach((v) {
        _orders?.add(Orders.fromJson(v));
      });
    }
  }
  List<Orders>? _orders;
OrderResponseEntity copyWith({  List<Orders>? orders,
}) => OrderResponseEntity(  orders: orders ?? _orders,
);
  List<Orders>? get orders => _orders;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_orders != null) {
      map['orders'] = _orders?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// order : {"id":1,"status":"0","paymentType":"0","date":"ddd","totalPrice":"5237.3666318744","lat":33,"long":22,"userId":1,"deliveryId":null,"carId":12,"created_at":"2025-04-20T05:48:35.000000Z","updated_at":"2025-04-20T05:48:35.000000Z"}
/// car : {"id":12,"desc":"the changes","price":"200","available":0,"killo":"255","ownerShipImageUrl":null,"colorId":1,"gearId":1,"brandId":1,"modelId":1,"userId":4,"created_at":"2025-04-18T07:36:10.000000Z","updated_at":"2025-04-20T05:48:34.000000Z"}

Orders ordersFromJson(String str) => Orders.fromJson(json.decode(str));
String ordersToJson(Orders data) => json.encode(data.toJson());
class Orders {
  Orders({
      Order? order, 
      Car? car,}){
    _order = order;
    _car = car;
}

  Orders.fromJson(dynamic json) {
    _order = json['order'] != null ? Order.fromJson(json['order']) : null;
    _car = json['car'] != null ? Car.fromJson(json['car']) : null;
  }
  Order? _order;
  Car? _car;
Orders copyWith({  Order? order,
  Car? car,
}) => Orders(  order: order ?? _order,
  car: car ?? _car,
);
  Order? get order => _order;
  Car? get car => _car;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_order != null) {
      map['order'] = _order?.toJson();
    }
    if (_car != null) {
      map['car'] = _car?.toJson();
    }
    return map;
  }

}

/// id : 12
/// desc : "the changes"
/// price : "200"
/// available : 0
/// killo : "255"
/// ownerShipImageUrl : null
/// colorId : 1
/// gearId : 1
/// brandId : 1
/// modelId : 1
/// userId : 4
/// created_at : "2025-04-18T07:36:10.000000Z"
/// updated_at : "2025-04-20T05:48:34.000000Z"

Car carFromJson(String str) => Car.fromJson(json.decode(str));
String carToJson(Car data) => json.encode(data.toJson());
class Car {
  Car({
      num? id, 
      String? desc, 
      String? price, 
      num? available, 
      String? killo, 
      dynamic ownerShipImageUrl, 
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
  dynamic _ownerShipImageUrl;
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
  dynamic ownerShipImageUrl,
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
  dynamic get ownerShipImageUrl => _ownerShipImageUrl;
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

/// id : 1
/// status : "0"
/// paymentType : "0"
/// date : "ddd"
/// totalPrice : "5237.3666318744"
/// lat : 33
/// long : 22
/// userId : 1
/// deliveryId : null
/// carId : 12
/// created_at : "2025-04-20T05:48:35.000000Z"
/// updated_at : "2025-04-20T05:48:35.000000Z"

Order orderFromJson(String str) => Order.fromJson(json.decode(str));
String orderToJson(Order data) => json.encode(data.toJson());
class Order {
  Order({
      num? id, 
      String? status, 
      String? paymentType, 
      String? date, 
      String? totalPrice, 
      num? lat, 
      num? long, 
      num? userId, 
      dynamic deliveryId, 
      num? carId, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _status = status;
    _paymentType = paymentType;
    _date = date;
    _totalPrice = totalPrice;
    _lat = lat;
    _long = long;
    _userId = userId;
    _deliveryId = deliveryId;
    _carId = carId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Order.fromJson(dynamic json) {
    _id = json['id'];
    _status = json['status'];
    _paymentType = json['paymentType'];
    _date = json['date'];
    _totalPrice = json['totalPrice'];
    _lat = json['lat'];
    _long = json['long'];
    _userId = json['userId'];
    _deliveryId = json['deliveryId'];
    _carId = json['carId'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _status;
  String? _paymentType;
  String? _date;
  String? _totalPrice;
  num? _lat;
  num? _long;
  num? _userId;
  dynamic _deliveryId;
  num? _carId;
  String? _createdAt;
  String? _updatedAt;
Order copyWith({  num? id,
  String? status,
  String? paymentType,
  String? date,
  String? totalPrice,
  num? lat,
  num? long,
  num? userId,
  dynamic deliveryId,
  num? carId,
  String? createdAt,
  String? updatedAt,
}) => Order(  id: id ?? _id,
  status: status ?? _status,
  paymentType: paymentType ?? _paymentType,
  date: date ?? _date,
  totalPrice: totalPrice ?? _totalPrice,
  lat: lat ?? _lat,
  long: long ?? _long,
  userId: userId ?? _userId,
  deliveryId: deliveryId ?? _deliveryId,
  carId: carId ?? _carId,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get id => _id;
  String? get status => _status;
  String? get paymentType => _paymentType;
  String? get date => _date;
  String? get totalPrice => _totalPrice;
  num? get lat => _lat;
  num? get long => _long;
  num? get userId => _userId;
  dynamic get deliveryId => _deliveryId;
  num? get carId => _carId;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['status'] = _status;
    map['paymentType'] = _paymentType;
    map['date'] = _date;
    map['totalPrice'] = _totalPrice;
    map['lat'] = _lat;
    map['long'] = _long;
    map['userId'] = _userId;
    map['deliveryId'] = _deliveryId;
    map['carId'] = _carId;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}