import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_hotel_room_app/service/app_unity.dart';
import 'package:my_hotel_room_app/service/helper_api.dart';

class RoomFormController extends GetxController {
  TextEditingController nameCustomer = TextEditingController();
  TextEditingController telCustomer = TextEditingController();

  Rx<DateTimeRange> dateRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now(),
  ).obs;

  Future<void> saveRoom(List roomId) async {
    try {
      for (int i = 0; i < roomId.length; i++) {
        bool isRentCheck = await isRent(
          roomId[i],
          AppUnity.dateFormatSend(
            date: AppUnity.myShowSnackBar(
              context: Get.context!,
              text: "จองไม่สำเร็จ",
              typeDialog: TypeDialog.error,
            ),
          ),
        );

        if (isRentCheck == false) {
          AppUnity.myShowSnackBar(
            context: Get.context!,
            text: "ไม่สามารถจองวันนี้ได้",
            typeDialog: TypeDialog.error,
          );
          return;
        }
      }

      await HelperApi().httpPost(
        path: "/roomRent/rent",
        data: jsonEncode({
          "customerName": nameCustomer.text,
          "customerPhone": telCustomer.text,
          "checkinDate": AppUnity.dateFormatSend(
            date: AppUnity.dateFormat(date: dateRange.value.start),
          ),
          "checkoutDate": AppUnity.dateFormatSend(
            date: AppUnity.dateFormat(date: dateRange.value.end),
          ),
          "rooms": roomId,
        }),
      );
      Get.back(result: true);
    } catch (err) {
      AppUnity.myShowSnackBar(
        context: Get.context!,
        text: err.toString(),
        typeDialog: TypeDialog.error,
      );
    }
  }

  Future<bool> isRent(int roomId, String data) async {
    try {
      var body = await HelperApi().httpPost(
        path: "/roomRent/isRent",
        data: jsonEncode({"roomId": roomId, "checkinDate": "$data 00:00:00"}),
      );

      List listcheckroom = body["result"];
      if (listcheckroom.isNotEmpty) {
        return false;
      } else {
        return true;
      }
    } catch (err) {
      AppUnity.myShowSnackBar(
        context: Get.context!,
        text: err.toString(),
        typeDialog: TypeDialog.error,
      );
      rethrow;
    }
  }
}
