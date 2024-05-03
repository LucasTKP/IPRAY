import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ipray/pages/signin/widgets/loading_signin.dart';
import 'package:ipray/pages/signin/signin_controller.dart';

class SignInPage extends StatelessWidget {
  final SignInController signInController;
  const SignInPage({super.key, required this.signInController});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFFFDE78), 
                  Color(0xFFFFFFFF),
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
                                image: DecorationImage(image: AssetImage('assets/images/login.png'), fit: BoxFit.cover),
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
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Registre se você está rezando o terço diariamente e participe do nosso ranking!',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Color(0xff585858)),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      ElevatedButton(
                        onPressed: () => signInController.signInWithGoogle(),
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
                              const Expanded(
                                child: Text(
                                  'Entrar com o Google',
                                  style: TextStyle(fontSize: 20, color: Color(0xFFE5B500), fontWeight: FontWeight.w500),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                LoadingSignIn(signInController: signInController)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
