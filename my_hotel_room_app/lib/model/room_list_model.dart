import 'dart:convert';

RoomListModel roomListModelFromJson(String str) =>
    RoomListModel.fromJson(json.decode(str));

String roomListModelToJson(RoomListModel data) => json.encode(data.toJson());

class RoomListModel {
  List<Result>? results;

  RoomListModel({this.results});

  factory RoomListModel.fromJson(Map<String, dynamic> json) => RoomListModel(
    results: List<Result>.from(
      (json["results"] ?? []).map((x) => Result.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "results": List<dynamic>.from((results ?? []).map((x) => x.toJson())),
  };
}

class Result {
  int? id;
  String? name;
  double? price;
  String? status;
  bool? check;

  Result({this.id, this.name, this.price, this.status, this.check});

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    name: json["name"],
    price: double.tryParse(json["price"].toString()),
    status: json["status"],
    check: false,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "status": status,
    "check": check,
  };
}
