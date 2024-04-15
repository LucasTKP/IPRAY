import 'package:flutter/material.dart';
import 'package:ipray/pages/home/home_controller.dart';

class ImageDaily extends StatelessWidget {
  const ImageDaily({super.key, required this.homeController});
  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 7,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(homeController.getImagePath()),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
