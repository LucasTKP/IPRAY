import 'package:flutter/material.dart';

class ImageDaily extends StatelessWidget {
  const ImageDaily({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    int dayOfWeek = now.weekday;
    String dayName = '';

    switch (dayOfWeek) {
      case 1:
        dayName = 'monday';
        break;
      case 2:
        dayName = 'tuesday';
        break;
      case 3:
        dayName = 'wednesday';
        break;
      case 4:
        dayName = 'thursday';
        break;
      case 5:
        dayName = 'friday';
        break;
      case 6:
        dayName = 'saturday';
        break;
      case 7:
        dayName = 'sunday';
        break;
    }

    // Construindo o caminho completo da imagem com base no nome do dia
    String imagePath = 'assets/images/$dayName.png';

    return AspectRatio(
      aspectRatio: 16 / 7,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
