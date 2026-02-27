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
      await HelperApi().httpPost(
        path: "/roomRent/rent",
        data: jsonEncode({
          "customerName": nameCustomer.text,
          "cutomerPhone": telCustomer.text,
          "checkinDate": AppUnity.dateFormatSend(
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
}
