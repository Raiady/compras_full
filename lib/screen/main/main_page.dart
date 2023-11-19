import 'package:compras_full/models/users/users_services.dart';
import 'package:compras_full/screen/home/home_page.dart';
import 'package:compras_full/screen/product/product_add_page.dart';
import 'package:compras_full/screen/product/product_list_page.dart';
import 'package:compras_full/screen/userprofile/user_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 201, 26, 13),
          elevation: 2.0,
          title: const Text(
            "LIST COMPRAS",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.all(10.0),
              child: Image.asset('assets/carrinho-de-compras.png'),
            )
          ]),
      body: [
        const ProductListPage(),
        const HomePage(),
        const UserProfilePage(),
      ][_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (int position) {
          setState(() {
            _index = position;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.line_style_outlined),
            label: 'lista',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_box_outlined),
            label: 'Perfil de Usuário',
          )
        ],
      ),
      drawer: Consumer<UsersServices>(
        builder: (context, usersServices, child) {
          return Drawer(
            child: Column(
              children: [
                DrawerHeader(
                  child: Column(
                    children: [
                      Flexible(
                        flex: 1,
                        child: ClipOval(
                          child: Image.network(
                            usersServices.users!.image!,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(usersServices.users!.userName!.toUpperCase()),
                      Text(usersServices.users!.email!.toLowerCase()),
                    ],
                  ),
                ),
                Column(
                  children: [
                    const ListTile(
                      title: Text('Lista de Compras'),
                    ),
                    const Divider(
                      height: 2,
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UserProfilePage(),
                          ),
                        );
                      },
                      title: const Text('Perfil de usuário'),
                    ),
                    ExpansionTile(
                        title: const Text("Gerenciamento de Produtos"),
                        leading: const Icon(Icons.person), //add icon
                        childrenPadding:
                            const EdgeInsets.only(left: 60), //children padding
                        children: [
                          ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ItemAddPage(),
                                ),
                              );
                            },
                            title: const Text('Cadastro de Produtos'),
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ProductListPage(),
                                ),
                              );
                            },
                            title: const Text('Listagem de Produtos'),
                          ),
                        ]),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
