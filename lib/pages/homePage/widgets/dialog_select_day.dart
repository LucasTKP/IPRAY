import 'package:flutter/material.dart';
import 'package:ipray/controllers/pray_controller.dart';
import 'package:ipray/controllers/user_controller.dart';
import 'package:ipray/models/users_models.dart';
import 'package:ipray/utils/formatter_date.dart';
import 'package:provider/provider.dart';

void dialogSelectDay(BuildContext context, DateTime daySelected) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Consumer<UserController>(
        builder: (context, controller, child) {
          UserIpray? user = controller.user;

          ValueNotifier<bool> praySelected = ValueNotifier<bool>(user != null
              ? user.praies.any((praies) => praies.date == daySelected)
              : false);

          return AlertDialog(
            backgroundColor: const Color.fromARGB(255, 255, 251, 219),
            content: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    formatDate(daySelected.toString()),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: 3,
                    decoration: const BoxDecoration(color: Color(0XFFBF9000)),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Você rezou o terço neste dia?',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 15),
                  ValueListenableBuilder<bool>(
                    valueListenable: praySelected,
                    builder: (context, pray, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color(0XFFBF9000), width: 2),
                              borderRadius: BorderRadius.circular(8),
                              color: pray
                                  ? const Color(0XFFE0CF96)
                                  : Colors.transparent,
                            ),
                            child: InkWell(
                              onTap: () {
                                praySelected.value = true;
                              },
                              child: Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 8),
                                    child: Text(
                                      '🙏',
                                      style: TextStyle(fontSize: 50),
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    height: 2,
                                    decoration: const BoxDecoration(
                                        color: Color(0XFFBF9000)),
                                  ),
                                  const Text(
                                    'Sim',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 3,
                            height: 80,
                            decoration:
                                const BoxDecoration(color: Color(0XFFBF9000)),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color(0XFFBF9000), width: 2),
                              borderRadius: BorderRadius.circular(8),
                              color: pray
                                  ? Colors.transparent
                                  : const Color(0XFFE0CF96),
                            ),
                            child: InkWell(
                              onTap: () {
                                praySelected.value = false;
                              },
                              child: Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 8),
                                    child: Text(
                                      '😭',
                                      style: TextStyle(fontSize: 50),
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    height: 2,
                                    decoration: const BoxDecoration(
                                        color: Color(0XFFBF9000)),
                                  ),
                                  const Text(
                                    'Não',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  )
                ],
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 255, 251, 219),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      side: MaterialStateProperty.all<BorderSide>(
                        const BorderSide(width: 2, color: Color(0XFFBF9000)),
                      ),
                    ),
                    child: const Text(
                      'Fechar',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 27, 27, 27),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  ElevatedButton(
                    onPressed: () async {
                      final prayController = context.read<PrayController>();

                      if (praySelected.value) {
                        if (user != null) {
                          final response = await prayController.createPray(
                              daySelected, user.id);

                          if (response != null) {
                            final newUser = user;
                            newUser.praies.add(response);
                            newUser.copyWith(total: newUser.total + 1);
                            controller.setUser(newUser);
                            if (context.mounted) Navigator.of(context).pop();
                          }
                        }
                      } else {
                        if (user != null) {
                          final dateIndex = user.praies
                              .indexWhere((pray) => pray.date == daySelected);

                          if (dateIndex > -1) {
                            final response =
                                await prayController.deletePray(daySelected, user.id);
                            if (response) {
                              final newUser = user;
                              newUser.praies.removeAt(dateIndex);
                              newUser.copyWith(total: newUser.total - 1);
                              controller.setUser(newUser);
                              if (context.mounted) Navigator.of(context).pop();
                            }
                          } else {
                            if (context.mounted) Navigator.of(context).pop();
                          }
                        }
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        const Color(0XFFBF9000),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Salvar',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 255, 251, 219),
                      ),
                    ),
                  ),
                ],
              )
            ],
            insetPadding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          );
        },
      );
    },
  );
}

