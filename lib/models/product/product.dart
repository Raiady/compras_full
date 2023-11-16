import 'package:cloud_firestore/cloud_firestore.dart';

class Produt {
  String? id;
  String? name;
  String? price;
  String? unit;
  String? image;
  bool? active = true;

  Produt({this.id, this.name, this.price, this.unit, this.image, this.active});

  Produt.fromDocument(DocumentSnapshot doc) {
    id = doc.id;
    name = doc.get('name') as String;
    price = doc.get('price') as String;
    unit = doc.get('unit') as String;
    image = doc.get('image') as String;
    active = doc.get('active') as bool;
  }

  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      'name': name,
      'price': price,
      'unit': unit,
      'active': active
    };
  }

  Produt.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    unit = map['unit'];
    price = map['price'];
    image = map['image'];
    active = map['active'];
  }
}
