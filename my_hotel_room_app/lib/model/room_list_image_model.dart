// To parse this JSON data, do
//
//     final roomListImageModel = roomListImageModelFromJson(jsonString);

import 'dart:convert';

RoomListImageModel roomListImageModelFromJson(String str) => RoomListImageModel.fromJson(json.decode(str));

String roomListImageModelToJson(RoomListImageModel data) => json.encode(data.toJson());

class RoomListImageModel {
    List<Result>? results;

    RoomListImageModel({
        this.results,
    });

    factory RoomListImageModel.fromJson(Map<String, dynamic> json) => RoomListImageModel(
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from((results ?? []).map((x) => x.toJson())),
    };
}

class Result {
    int? id;
    String? name;
    int? roomId;

    Result({
        this.id,
        this.name,
        this.roomId,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        roomId: json["roomId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "roomId": roomId,
    };
}
