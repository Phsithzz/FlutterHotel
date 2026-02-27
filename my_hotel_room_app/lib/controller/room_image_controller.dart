import 'dart:convert';

import 'package:get/get.dart';
import 'package:my_hotel_room_app/model/room_list_image_model.dart';
import 'package:my_hotel_room_app/service/helper_api.dart';

class RoomImageController extends GetxController {
  Rx<RoomListImageModel> imageData = RoomListImageModel().obs;

  Future<void> getImageData(int roomId) async {
    var data = await HelperApi().httpGet(path: "/roomImage/list/${roomId}");
    imageData.value = roomListImageModelFromJson(jsonEncode(data));
    update();
  }
}
