import 'package:compras_full/commons/mypicked_image.dart';
import 'package:compras_full/models/users/users.dart';
import 'package:compras_full/models/users/users_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class UserProfileEditPage extends StatefulWidget {
  const UserProfileEditPage({this.users, super.key});
  final Users? users;

  @override
  State<UserProfileEditPage> createState() => _UserProfileEditPageState();
}

class _UserProfileEditPageState extends State<UserProfileEditPage> {
  @override
  Widget build(BuildContext context) {
    bool imageUpdate = false;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 151, 150, 150),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Consumer2<UsersServices, MyPickedImage>(
          builder: (context, usersServices, myPickedImage, child) {
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "Editando Perfil de Usuário",
                  style: TextStyle(
                    color: Color.fromARGB(255, 2, 32, 3),
                    fontSize: 28,
                    fontFamily: 'Lustria',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() async {
                      imageUpdate = await Provider.of<MyPickedImage>(context,
                              listen: false)
                          .myPickedImage();
                    });
                  },
                  child: imageUpdate & kIsWeb
                      ? Consumer<MyPickedImage>(
                          builder: (context, myPickedImage, child) {
                            if (kIsWeb) {
                              return ClipOval(
                                child: Image.memory(
                                  myPickedImage.webImage!,
                                  height: 90,
                                  width: 90,
                                  fit: BoxFit.cover,
                                ),
                              );
                            } else {
                              return ClipOval(
                                child: Image.file(
                                  myPickedImage.pickImage!,
                                  height: 90,
                                  width: 90,
                                  fit: BoxFit.cover,
                                ),
                              );
                            }
                          },
                        )
                      : ClipOval(
                          child: Image.network(
                            usersServices.users!.image!,
                            height: 90,
                            width: 90,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  initialValue: usersServices.users!.userName,
                  decoration: InputDecoration(
                    label: const Text('Nome do Usuário'),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 1.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
