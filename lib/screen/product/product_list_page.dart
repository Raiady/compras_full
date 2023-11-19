import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:compras_full/models/product/product_service.dart';
import 'package:flutter/material.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  TextEditingController editingController = TextEditingController();
  ProductService productService = ProductService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Listagem de Produtos"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: editingController,
              decoration: const InputDecoration(
                labelText: "Buscar",
                hintText: "Filtra por nome do produto",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
              ),
              onChanged: (name) {
                
              },
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          StreamBuilder(
            stream: productService.getAllProducts(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              //verificar a existência de dados
              if (snapshot.hasData) {
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: ((context, index) {
                      DocumentSnapshot docSnapshot = snapshot.data!.docs[index];
                      return Padding(
                        padding: const EdgeInsets.only(
                          left: 10.0,
                          right: 10.0,
                          top: 10,
                        ),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 216,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 18.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              docSnapshot['name'],
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              'R\$ ${docSnapshot['price'].toString()}',
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      iconSize: 18,
                                      onPressed: () {},
                                      icon: const Icon(Icons.edit),
                                    ),
                                    IconButton(
                                      iconSize: 18,
                                      onPressed: () async {
                                        bool ok =
                                            await productService.delete('id');
                                        if (ok && mounted) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  'Produto deletado com sucesso.'),
                                            ),
                                          );
                                        }
                                      },
                                      icon: const Icon(Icons.delete),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                );
              }
              return const Center(
                // child: Text(
                //   'Dados indisponíveis no momento',
                //   style: TextStyle(color: Colors.brown, fontSize: 20),
                // ),
                child: CircularProgressIndicator(
                  backgroundColor: Colors.cyanAccent,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'fbp',
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Theme.of(context).primaryColorLight,
        onPressed: () {
          // Navigator.of(context).push(
          // MaterialPageRoute(
          // builder: (context) => ProductAddPage2(),
          // ),
          // );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
