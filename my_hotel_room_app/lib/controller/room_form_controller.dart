import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoomFormController extends GetxController {
  TextEditingController nameCustomer = TextEditingController();
  TextEditingController telCustomer = TextEditingController();

  Rx<DateTimeRange> dateRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now(),
  ).obs;

  Future<void> saveRoom() async{
    try {
      
    } catch (err) {
      
      
    }
  }
}
