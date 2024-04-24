import 'package:ipray/controllers/supabase_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class AlertBoxController {
  late SupabaseController supabaseController;

  AlertBoxController({required this.supabaseController});

  sendToGoogleDrive() async {
    final Uri url = Uri.parse('https://drive.google.com/drive/folders/1aZM1Dqypw4tZpQe58FmXza-wL0XHnZ4V?usp=drive_link');

     if (!await launchUrl(url)) {
      throw Exception(url);
    }
  }
}
