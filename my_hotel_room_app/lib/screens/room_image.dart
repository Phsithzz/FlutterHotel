import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_hotel_room_app/controller/room_image_controller.dart';
import 'package:my_hotel_room_app/model/room_list_model.dart';
import 'package:my_hotel_room_app/service/app_unity.dart';

class RoomImage extends StatefulWidget {
  const RoomImage({super.key, required this.roomListModel});
  final Result roomListModel;
  @override
  State<RoomImage> createState() => _RoomImageState();
}

class _RoomImageState extends State<RoomImage> {
  final controller = Get.put(RoomImageController());

  @override
  void initState() {
    controller.getImageData(widget.roomListModel.id ?? 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("รูปห้องพ้ก ${widget.roomListModel.name}")),
      body: Obx(
        ()=>GridView.count(crossAxisCount: 2,
        children:(controller.imageData.value.results ?? [])
        .map(
          (e)=>Container(
            margin: const EdgeInsets.all(10),
            child: Image.network(
              "http://10.0.2.2:3000/uploads/${e.name}",
              errorBuilder: (context,error,stackTrace)=>
              Image.network(AppUnity.urlNoImage),

            ),
          ),
        )
        .toList(),
        )
      ),
    );
  }
}
