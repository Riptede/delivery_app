import 'package:delivery_app/logg/logger.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    

    final theme = Theme.of(context);
    TextEditingController emailController = TextEditingController(text: 'admin');
    TextEditingController passwordController = TextEditingController(text: 'admin');

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: Text(
          "Delivery app",
          style: theme.textTheme.titleLarge,
        ),
        centerTitle: true,
        backgroundColor: theme.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: (Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: 30,
          ),
          Align(
              child: Text(
            "Вход",
            style: theme.textTheme.headlineMedium,
          )),
          const SizedBox(
            height: 30,
          ),
          email(passwordController, emailController),
          const SizedBox(
            height: 30,
          ),
          password(passwordController),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              SizedBox(
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFf0fc8c),
                  ),
                  onPressed: () {
                    if (emailController.text =='admin' &&
                        passwordController.text == 'admin') {
                      logger.i("Вход");
                      Navigator.of(context).pushReplacementNamed("/home", );
                    } else if (emailController.text.isEmpty || passwordController.text.isEmpty) {
                      logger.i("Поля не должны быть пустыми");
                      
                    } else {
                      logger.i("Неправильные данные");
                    }
                  },
                  child: const Text(
                    "Вход",
                    style: TextStyle(
                      color: Color(0xFF484444),
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                child: TextButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Создать аккаунт",
                    style: TextStyle(
                      color: Color(0xFFf0fc8c),
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          )
        ])),
      ),
    );
  }

  TextField password(TextEditingController passwordController) {
    return TextField(
          onChanged: (value) {},
          focusNode: passwordFocus,
          decoration: const InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFf0fc8c),
              ),
            ),
            filled: true,
            fillColor: Color.fromARGB(255, 100, 99, 99),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFf0fc8c),
              ),
            ),
            labelText: 'password',
            labelStyle: TextStyle(color: Color(0xFFf0fc8c)),
            hintText: 'Enter your password',
          ),
          style: const TextStyle(color: Colors.white),
          controller: passwordController,
          keyboardType: TextInputType.emailAddress,
        );
  }

  TextField email(TextEditingController passwordController, TextEditingController emailController) {
    return TextField(
          onChanged: (value) {},
          onSubmitted: (value) {
            if (passwordController.text.isEmpty) {
              passwordFocus.requestFocus();
            }
          },
          focusNode: emailFocus,
          decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFf0fc8c),
                ),
              ),
              filled: true,
              fillColor: Color.fromARGB(255, 100, 99, 99),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFf0fc8c),
                ),
              ),
              labelText: 'Email',
              labelStyle: TextStyle(color: Color(0xFFf0fc8c)),
              hintText: 'Enter your email',
              ),
          style: const TextStyle(color: Colors.white),
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
        );
  }
}
