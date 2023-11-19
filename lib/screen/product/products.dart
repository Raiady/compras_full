import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:compras_full/models/product/product.dart';
import 'package:compras_full/models/product/product_service.dart';
import 'package:compras_full/screen/product/product_add_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ItemListPage extends StatefulWidget {
  const ItemListPage({Key? key}) : super(key: key);

  @override
  State<ItemListPage> createState() => _ItemListPageState();
}

class _ItemListPageState extends State<ItemListPage> {
  @override
  Widget build(BuildContext context) {
    ProductService productService = ProductService();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Produto"),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          StreamBuilder(
            stream: productService.firestoreRef.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              //verificar a existência de dados
              if (snapshot.hasData) {
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: ((context, index) {
                      DocumentSnapshot docSnapshot = snapshot.data!.docs[index];
                      Produt itens = Produt(
                          id: docSnapshot.id,
                          name: docSnapshot['name'],
                          unit: docSnapshot['unit'],
                          image: docSnapshot['image'],
                          price: docSnapshot['price'],
                          active: docSnapshot['active']);
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
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(
                                            height: 80,
                                            width: 80,
                                            // child: Image.network(cartProduct.product.images.first),
                                            child: Image.network(
                                                docSnapshot['image'] ?? '',
                                                errorBuilder: (BuildContext
                                                        context,
                                                    Object exception,
                                                    StackTrace? stackTrace) {
                                              return const CircularProgressIndicator(
                                                backgroundColor:
                                                    Colors.cyanAccent,
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(Colors.red),
                                              );
                                            }
                                                // docSnapshot['image']
                                                ),
                                          ),
                                          Text(
                                            docSnapshot['name'],
                                            style:
                                                const TextStyle(fontSize: 12),
                                          ),
                                          Text(
                                            docSnapshot['price'],
                                            style:
                                                const TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      iconSize: 18,
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => ItemAddPage(
                                              id: itens.id,
                                              name: itens.name,
                                              price: itens.price,
                                              active: itens.active,
                                              unit: itens.unit,
                                              image: itens.image,
                                            ),
                                          ),
                                        );
                                      },
                                      icon: const Icon(Icons.edit),
                                    ),
                                    IconButton(
                                      iconSize: 18,
                                      onPressed: () async {
                                        if (kDebugMode) {
                                          print(itens.id!);
                                        }
                                        bool ok = await productService
                                            .delete(itens.id!);
                                        if (ok) {
                                          // ignore: use_build_context_synchronously
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
                child: Text(
                  'Dados indisponíveis no momento',
                  style: TextStyle(color: Colors.brown, fontSize: 20),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ItemAddPage(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
