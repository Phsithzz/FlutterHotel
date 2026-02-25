import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_hotel_room_app/controller/room_form_controller.dart';
import 'package:my_hotel_room_app/service/app_unity.dart';

class RoomForm extends StatefulWidget {
  final List<int> roomId;
  const RoomForm({super.key, required this.roomId});

  @override
  State<RoomForm> createState() => _RoomFormState();
}

class _RoomFormState extends State<RoomForm> {
  final controller = Get.put(RoomFormController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("กรอกรายละเอียดการจอง")),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextFormField(
            controller: controller.nameCustomer,
            decoration: const InputDecoration(
              hintText: "ชื่อผู้จอง",
              labelText: "ชื่อผู้จอง",
            ),
          ),

          const SizedBox(height: 15),

          TextFormField(
            controller: controller.telCustomer,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              hintText: "เบอร์โทร",
              labelText: "เบอร์โทร",
            ),
          ),

          const SizedBox(height: 15),

          TextFormField(
            readOnly: true,
            controller: TextEditingController()
              ..text =
                  "${AppUnity.dateFormat(date: controller.dateRange.value.start)} - ${AppUnity.dateFormat(date: controller.dateRange.value.end)}",
            onTap: () async {
              DateTimeRange? dateTimeRange = await AppUnity.showDatePickerRang(
                context: context,
                currentDate: controller.dateRange.value.start,
                dateTimeRange: controller.dateRange.value,
                lastDate: DateTime.now().add(const Duration(days: 365 * 10)),
              );
              if (dateTimeRange != null) {
                controller.dateRange.value = dateTimeRange;
                controller.update();
              }
            },
            decoration: const InputDecoration(
              hintText: "วันที่ Checkin/Checkout",
              labelText: "วันที่ Checkin/Checkout",
            ),
          ),
        ],
      ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(10),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Get.theme.primaryColor,
            foregroundColor: Colors.white,
          ),
          child: const Text("บันทึก"),
        ),
      ),
    );
  }
}
