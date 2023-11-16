import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:compras_full/models/sale/sale.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class SaleService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late CollectionReference firestoreRef;

  SaleService() {
    firestoreRef = _firestore.collection('sales');
  }

  Future<bool> add(
      {Compras? compras, dynamic imageFile, required bool plat}) async {
    // ignore: no_leading_underscores_for_local_identifiers, unused_local_variable
    final _uuid = const Uuid().v1();
    try {
      final doc = await firestoreRef.add(compras!.toMap()).then((value) {
        compras.id = value.id;
        firestoreRef.doc(compras.id).set(compras.toMap());
      }); //após receber o objeto do form na view eu passo ele para json e manda para o firebase salvar
      compras.id = doc.id;

      return Future.value(true);
    } on FirebaseException catch (e) {
      if (e.code != 'OK') {
        debugPrint('Problemas ao gravar dados');
      } else if (e.code == 'ABORTED') {
        debugPrint('Inclusão de dados abortada');
      }
      return Future.value(false);
    }
  }
}
