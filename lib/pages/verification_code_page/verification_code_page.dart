import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class VerificationCode extends StatelessWidget {
  const VerificationCode({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 65),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Hero(
                      tag: ImageConstant.logoClub,
                      child: SizedBox(
                        child: Image.asset(
                          ImageConstant.logoClub,
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.contain,
                          height: 230,
                        ),
                      ),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Digite o código de verificação',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 7),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Enviamos um código para (92)99999-9999',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // const VerificationInput(),
                  const SizedBox(height: 40),
                  // CustomButton(
                  //   label: Text(
                  //     'Cadastrar',
                  //     style: TextStyle(
                  //       color: context.colors.onPrimary,
                  //       fontSize: 15,
                  //     ),
                  //   ),
                  //   height: 50,
                  //   onPressed: () {},
                  // ),
                  const SizedBox(height: 28),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
