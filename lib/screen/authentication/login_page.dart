import 'package:compras_full/models/users/users_services.dart';
import 'package:compras_full/screen/authentication/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 110, 62, 13),
      body: Padding(
        padding: const EdgeInsets.all(60),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(35.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Image.asset(
                      'assets/carrinho-de-compras.png',
                      width: 100,
                      height: 82,
                    ),
                    const Text(
                      'List APP',
                      style: TextStyle(
                        color: Color(0xFFB51D1D),
                        fontSize: 30,
                        fontFamily: 'Grenze Gotisch',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              TextFormField(
                controller: _email,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email, color: Colors.white),
                    label: Text(
                      'E-MAIL',
                      style: TextStyle(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 252, 252, 252),
                            width: 1.3))),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextFormField(
                obscureText: true,
                controller: _password,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.password, color: Colors.white),
                    label: Text(
                      'SENHA',
                      style: TextStyle(color: Colors.white),
                    ),
                    suffixIcon:
                        Icon(Icons.remove_red_eye_sharp, color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 252, 252, 252),
                            width: 1.5))),
                style: const TextStyle(color: Colors.white),
              ),
              Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(top: 1.0),
                  child: const Text('Esqueceu a senha?',
                      style: TextStyle(
                          color: Color.fromARGB(255, 64, 255, 191),
                          fontWeight: FontWeight.bold))),
              Consumer<UsersServices>(
                builder: (context, usersServices, child) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          usersServices.signIn(
                              email: _email.text,
                              password: _password.text,
                              onSucess: () {
                                Navigator.pushReplacementNamed(
                                    context, '/mainpage');
                              },
                              onFail: (e) {
                                var snack = SnackBar(
                                  content: Text(e),
                                  backgroundColor:
                                      const Color.fromARGB(255, 236, 21, 6),
                                  elevation: 20,
                                  behavior: SnackBarBehavior.floating,
                                  margin: const EdgeInsets.all(20),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snack);
                              });
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 1.5,
                            minimumSize: const Size.fromHeight(50),
                            shape: LinearBorder.bottom()),
                        child: const Text(
                          'Entrar',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Ou',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minimumSize: const Size.fromHeight(50),
                        ),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/google.png',
                              height: 50,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            const Text(
                              "Login com Google",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text(' Ainda não possui login ?'),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignUpPage(),
                                ),
                              );
                            },
                            child: const Text(
                              'Inscreva-se',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 23, 231, 179),
                                  fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
