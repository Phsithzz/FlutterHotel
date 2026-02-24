import 'dart:convert';

import 'package:get/get.dart';
import 'package:my_hotel_room_app/model/room_list_model.dart';
import 'package:my_hotel_room_app/service/app_unity.dart';
import 'package:my_hotel_room_app/service/helper_api.dart';

class HomePageController extends GetxController {
  Rx<RoomListModel> roomList = RoomListModel().obs;

  Future<void> getAllRoom() async {
    try {
      var body = await HelperApi().httpGet(path: "/room/list");
      roomList.value = roomListModelFromJson(jsonEncode(body));

    } catch (e) {
      AppUnity.myShowSnackBar(
        context: Get.context!,
        text: e.toString(),
        typeDialog: TypeDialog.error,
      );
    }
  }
}
