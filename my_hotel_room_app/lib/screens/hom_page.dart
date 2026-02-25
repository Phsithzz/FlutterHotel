import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:my_hotel_room_app/controller/home_page_controller.dart';
import 'package:my_hotel_room_app/screens/room_form.dart';
import 'package:my_hotel_room_app/service/app_unity.dart';

class HomPage extends StatefulWidget {
  const HomPage({super.key});

  @override
  State<HomPage> createState() => _HomPageState();
}

class _HomPageState extends State<HomPage> {
  
  final controller = Get.put(HomePageController());

  @override
  void initState() {
    controller.getAllRoom();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("รายการห้อง")),
      body: Obx(
        () => ListView(
          children: (controller.roomList.value.results ?? [])
              .map(
                (e) => ListTile(
                  leading: Checkbox(
                    value: e.check,
                    onChanged: (val) {
                      e.check = val;
                      controller.roomList.refresh();
                      controller.update();
                    },
                  ),
                  title: Text(e.name ?? ""),
                  subtitle: Text("${AppUnity.f(text: e.price ?? 0)} บาท"),
                ),
              )
              .toList(),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if ((controller.roomList.value.results ?? [])
              .where((e) => e.check ?? false)
              .toList()
              .isEmpty) {
            AppUnity.myShowSnackBar(
              context: context,
              text: "กรุณาเลือกห้องพัก",
              typeDialog: TypeDialog.warning,
            );
            return;
          }
          Get.to(() =>  RoomForm(
            roomId:(controller.roomList.value.results ?? [])
            .where((e)=>e.check ?? false)
            .map((e)=>e.id ?? 0)
            .toList(),
          ));
        },
        child: const Icon(Icons.book),
      ),
    );
  }
}
