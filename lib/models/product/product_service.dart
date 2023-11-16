import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:compras_full/models/product/product.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late CollectionReference firestoreRef;
  FirebaseStorage storage = FirebaseStorage.instance;

  ProductService() {
    firestoreRef = _firestore.collection('itens');
  }

  Stream<QuerySnapshot> getAllProducts() {
    return firestoreRef.snapshots();
  }

  Future<bool> add(
      {Produt? itens, dynamic imageFile, required bool plat}) async {
    final uuid = const Uuid().v1();
    try {
      final doc = await firestoreRef.add(itens!.toMap());
      itens.id = doc.id;

      Reference storageRef = storage.ref().child('itens').child(itens.id!);
      final UploadTask task;

      if (!plat) {
        task = storageRef.child(uuid).putFile(
              imageFile,
              SettableMetadata(
                contentType: 'image/jpeg',
                customMetadata: {
                  'upload_by': 'Raiady',
                  'description': '${itens.name}'
                },
              ),
            );
      } else {
        task = storageRef.child(uuid).putData(
              imageFile,
              SettableMetadata(
                contentType: 'image/jpeg',
                customMetadata: {
                  'upload_by': 'Raiady',
                  'description': '${itens.name}'
                },
              ),
            );
      }

      final String url =
          await (await task.whenComplete(() {})).ref.getDownloadURL();
      DocumentReference docRef = firestoreRef.doc(itens.id);
      await docRef.update({'image': url});
      debugPrint('Gravando os  dados');

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

  Future<bool> update(
      {String? itenId, Produt? itenItem, dynamic imageFile, bool? plat}) async {
    try {
      await firestoreRef.doc(itenItem?.id).set(itenItem?.toMap());

      Reference storageRef = storage.ref().child('itens').child(itenId!);
      final UploadTask task;

      if (!plat!) {
        task = storageRef.child(itenId).putFile(
              imageFile,
              SettableMetadata(
                contentType: 'image/jpeg',
                customMetadata: {
                  'update_by': 'Raiady',
                },
              ),
            );
      } else {
        task = storageRef.child(itenId).putData(
              imageFile,
              SettableMetadata(
                contentType: 'image/jpeg',
                customMetadata: {
                  'update_by': 'Raiady',
                },
              ),
            );
      }

      final String url =
          await (await task.whenComplete(() {})).ref.getDownloadURL();
      DocumentReference docRef = firestoreRef.doc(itenId);
      await docRef.update({'image': url});

      return Future.value(true);
    } on FirebaseException catch (e) {
      if (e.code != 'ok') {
        debugPrint('Problemas ao atualizar dados');
      } else if (e.code == 'ABORTED') {
        debugPrint('Edição abortada');
      }
      return Future.value(false);
    }
  }

  Future<bool> delete(String itensId) async {
    try {
      await firestoreRef.doc(itensId).delete();
      await storage.ref().child('itens').child(itensId).delete();
      return Future.value(true);
    } on FirebaseException catch (e) {
      if (e.code != 'OK') {
        debugPrint('Problemas ao deletar dados');
      } else if (e.code == 'ABORTED') {
        debugPrint('Deleção abortada');
      }
      return Future.value(false);
    }
  }
}
