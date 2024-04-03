import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color(0xFFEBE0BA)),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 8,
          horizontal: MediaQuery.of(context).size.width * 0.05,
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('🙏120',
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
                Text('Total',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700))
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '🔥12',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                ),
                Text('Seguidos',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700))
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('😭12',
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
                Text('Perdidos',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700))
              ],
            )
          ],
        ),
      ),
    );
  }
}
