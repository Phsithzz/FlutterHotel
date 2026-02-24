import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:my_hotel_room_app/controller/home_page_controller.dart';
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
        onPressed: () {},
        child: const Icon(Icons.book),
      ),
    );
  }
}
