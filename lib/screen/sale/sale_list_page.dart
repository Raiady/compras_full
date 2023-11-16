import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:compras_full/models/sale/sale.dart';
import 'package:compras_full/models/sale/sale_service.dart';
import 'package:flutter/material.dart';

class SaleListPage extends StatefulWidget {
  const SaleListPage({super.key});

  @override
  State<SaleListPage> createState() => _SaleListPageState();
}

class _SaleListPageState extends State<SaleListPage> {
  @override
  Widget build(BuildContext context) {
    SaleService saleService = SaleService();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Vendas"),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          StreamBuilder(
              stream: saleService.firestoreRef.snapshots(),
              builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: ((context, index) {
                          DocumentSnapshot docSnapshot =
                              snapshot.data!.docs[index];
                          // ignore: unused_local_variable
                          Compras compras = Compras(
                              id: docSnapshot.id,
                              descricao: docSnapshot['descricao'],
                              vlr_total: docSnapshot['vlr_total'],
                              dt_venda: docSnapshot['dt_venda'],
                              forma_pagamento: docSnapshot['forma_pagamento'],
                              pago: docSnapshot['pago']);
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
                                              Text(
                                                docSnapshot['forma_pagamento'],
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              ),
                                              Text(
                                                docSnapshot['vlr_total'],
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              ),
                                              Text(
                                                docSnapshot['dt_venda'],
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // IconButton(iconSize: 18,onPressed: (){
                                        //   Navigator.of(context).push(
                                        //     MaterialPageRoute(builder: ()=>

                                        //     )
                                        //   )
                                        // },
                                        // )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        })),
                  );
                }
                return const Center(
                  child: Text(
                    'Dados indisponíveis no momento',
                    style: TextStyle(color: Colors.brown, fontSize: 20),
                  ),
                );
              }))
        ],
      ),
    );
  }
}
