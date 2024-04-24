import 'package:flutter/material.dart';
import 'package:ipray/pages/splash/components/alert_box_version_app/alert_box_controller.dart';

class AlertBoxPage extends StatelessWidget {
  final AlertBoxController alertBoxController;
  const AlertBoxPage({super.key, required this.alertBoxController});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Container(
        color: Colors.black.withOpacity(0.7),
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                color: const Color(0xFFFFE9A5),
                border: Border.all(color: const Color(0XFFBF9000), width: 3)),
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Aviso',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Seu aplicativo está desatualizado, clique no botão abaixo entre no Google Drive e baixe a ultima versão!',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => alertBoxController.sendToGoogleDrive(),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: const BorderSide(color: Color(0XFFBF9000), width: 2),
                      ),
                    ),
                    overlayColor: MaterialStateProperty.all(const Color(0xFFD5C681)),
                    backgroundColor: MaterialStateProperty.all(const Color(0xFFFFE9A5)),
                  ),

                  child: const Text(
                    "Google Drive",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

