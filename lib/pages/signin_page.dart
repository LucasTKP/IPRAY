import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ipray/components/loading_user_controller.dart';
import 'package:ipray/controllers/user_controller.dart';
import 'package:ipray/service/dio_service_imp.dart';
import 'package:ipray/service/sington_service.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final UserController _controller = UserController(DioServiceImp());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFFFDE78), // #FFDE78
                Color(0xFFFFFFFF), // #FFFFFF
              ],
            ),
          ),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.1,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * .60,
                        child: AspectRatio(
                          aspectRatio: 1 / 1,
                          child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/login.png'),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Login',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Registre se você está rezando o terço diariamente e participe do nosso ranking!',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff585858)),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _controller.isLoading.value = true;
                        onError(String error) {
                          final snackBar = SnackBar(
                            content: Text(error),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }

                        _controller.signInWithGoogle(onError).then((result) {
                          if (result != null) {
                            final email = result.user?.email ?? "";
                            _controller.getUser(email).then((response) {
                              _controller.isLoading.value = false;
                              if (response != null) {
                                if (response.id != 0) {
                                  SingtonService().user = response;
                                  Navigator.pushReplacementNamed(
                                      context, '/home');
                                } else {
                                  Navigator.pushReplacementNamed(
                                      context, '/signup');
                                }
                              }
                            });
                          }
                          _controller.isLoading.value = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: const BorderSide(
                            color: Color(0xFFE5B500),
                            width: 3,
                          ),
                        ),
                        backgroundColor: const Color(0xFFFDF4D5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 40,
                              height: 40,
                              child: SvgPicture.asset(
                                'assets/icons/google.svg',
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              'Entrar com o Google',
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Color(0xFFE5B500),
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              LoadingUserController(controller: _controller)
            ],
          ),
        ),
      ),
    );
  }
}
