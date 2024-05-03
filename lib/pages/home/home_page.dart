import 'package:flutter/material.dart';
import 'package:ipray/pages/home/home_controller.dart';
import 'package:ipray/pages/home/widgets/calendar/calendar_presenter.dart';
import 'package:ipray/pages/home/widgets/image_daily.dart';
import 'package:ipray/pages/home/widgets/phrase_daily.dart';
import 'package:ipray/pages/home/widgets/topbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.homeController});
  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Column(
                children: [
                  const TopBar(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.05,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        ImageDaily(homeController: homeController),
                        PhraseDaily(homeController: homeController),
                        const CalendarPresenter(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
