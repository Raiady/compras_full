import 'dart:io';

import 'package:compras_full/models/users/users_services.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:compras_full/models/users/users.dart';
import 'package:image_picker/image_picker.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _userName = TextEditingController();
  File? _pickImage;
  //variável utilizada para obter, especificamente,  imagens da câmera do table/celular
  Uint8List webImage = Uint8List(8);
  //utilizando para armazenar imagens da galeria (plataforma web)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 152, 84, 13),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 35),
                child: Image.asset(
                  'assets/carrinho-de-compras.png',
                  height: 90,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Registre-se",
                        style: TextStyle(
                          fontSize: 25,
                          color: Color.fromARGB(255, 213, 8, 8),
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  _pickImage == null || webImage.isEmpty
                      ? SizedBox(child: dottedBorder(color: Colors.blue))
                      : ClipOval(
                          child: kIsWeb
                              ? Image.memory(
                                  height: 50,
                                  width: 70,
                                  webImage,
                                  fit: BoxFit.fill,
                                )
                              : Image.file(
                                  _pickImage!,
                                  height: 50,
                                  width: 70,
                                  fit: BoxFit.fill,
                                ),
                        ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextFormField(
                controller: _userName,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person, color: Colors.white),
                    label: Text(
                      "Nome do usuário",
                      style: TextStyle(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1.3),
                    ),
                    focusedBorder:
                        OutlineInputBorder(borderSide: BorderSide(width: 1.5))),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextFormField(
                controller: _email,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email, color: Colors.white),
                    label: Text(
                      "E-mail",
                      style: TextStyle(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1.3),
                    ),
                    focusedBorder:
                        OutlineInputBorder(borderSide: BorderSide(width: 1.5))),
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
                      "Senha",
                      style: TextStyle(color: Colors.white),
                    ),
                    suffixIcon: Icon(Icons.remove_red_eye, color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1.3),
                    ),
                    focusedBorder:
                        OutlineInputBorder(borderSide: BorderSide(width: 1.5))),
                style: const TextStyle(color: Colors.white),
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(top: 1.0),
                child: const Text(
                  'Esqueceu a senha?',
                  style: TextStyle(
                    color: Color.fromARGB(255, 33, 243, 208),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      UsersServices usersServices = UsersServices();
                      Users users = Users();
                      users.email = _email.text;
                      users.userName = _userName.text;
                      users.password = _password.text;

                      if (await usersServices.signUp(
                          users, kIsWeb ? webImage : _pickImage, kIsWeb)) {
                        if (context.mounted) Navigator.of(context).pop();
                      } else {
                        if (context.mounted) {
                          var snackBar = const SnackBar(
                            content: Text('Algum erro aconteceu no registro'),
                            backgroundColor: Color.fromARGB(255, 161, 71, 66),
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.all(50),
                            elevation: 20,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 1.5,
                        minimumSize: const Size.fromHeight(50),
                        shape: LinearBorder.bottom()),
                    child: const Text(
                      'Registrar',
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
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Já tem uma conta?'),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Login',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 33, 243, 191),
                            fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dottedBorder({Color? color}) {
    return DottedBorder(
        dashPattern: const [5],
        color: Colors.white,
        child: Column(
          children: [
            IconButton(
              iconSize: 50,
              icon: const Icon(Icons.image_search_rounded, color: Colors.white),
              onPressed: () {
                _pickedImage();
              },
            ),
            const Text(
              "Foto",
              style: TextStyle(color: Colors.white),
            )
          ],
        ));
  }

  _pickedImage() async {
    ImagePicker picker = ImagePicker();
    XFile? image;
    // ignore: prefer_typing_uninitialized_variables
    var imageSelected;
    if (!kIsWeb) {
      image = await picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        imageSelected = File(image.path);
        setState(() {
          _pickImage = imageSelected;
        });
      }
    } else if (kIsWeb) {
      image = await picker.pickImage(
          source: ImageSource.gallery, maxHeight: 100, maxWidth: 100);
      if (image != null) {
        imageSelected = await image.readAsBytes();
        setState(() {
          webImage = imageSelected;
          _pickImage = File('a');
        });
      }
    }
  }
}
