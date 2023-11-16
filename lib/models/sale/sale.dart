// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:compras_full/models/product/product.dart';

class Compras {
  String? id;
  String? descricao;
  String? vlr_total;
  List<Produt> itens = [];
  String? dt_venda;
  String? obs;
  String? forma_pagamento;
  bool? pago = false;

  Compras(
      {this.id,
      this.descricao,
      this.vlr_total,
      this.dt_venda,
      this.forma_pagamento,
      this.pago});

  Compras.fromDocument(DocumentSnapshot doc) {
    id = doc.id;
    descricao = doc.get('descricao') as String;
    vlr_total = doc.get('vlr_total') as String;
    dt_venda = doc.get('unit') as String;
    obs = doc.get('obs') as String;
    forma_pagamento = doc.get('forma_pagamento') as String;
    pago = doc.get('pago') as bool;
  }

  Map<String, dynamic> toMap() {
    return {
      'descricao': descricao,
      'vlr_total': vlr_total,
      'dt_venda': dt_venda,
      'obs': obs,
      'forma_pagamento': forma_pagamento,
      'pago': pago
    };
  }

  Compras.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    descricao = map['descrica'];
    vlr_total = map['vlr_total'];
    dt_venda = map['dt_venda'];
    obs = map['obs'];
    forma_pagamento = map['forma_pagamento'];
    pago = map['pago'];
  }
}
