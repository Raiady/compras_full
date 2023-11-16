//classe de dados (DTO)
import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  String? id;
  String? userName;
  String? email;
  String? password;
  String? phone;
  String? birthday;
  String? socialMedia;
  String? image;
  Users(
      {this.id,
      this.userName,
      this.email,
      this.password,
      this.phone,
      this.birthday,
      this.socialMedia,
      this.image});

  //método para converter dados do objeto em formato compatível com JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'email': email,
      'phone': phone,
      'password': password,
      'socialMedia': socialMedia,
      'birthday': birthday,
    };
  }

  //método construtor para converter dados do objeto do tipo documento do firebase
  //em formato compatível com o Objeto Users (esta própria classe)
  Users.fromJson(DocumentSnapshot doc) {
    id = doc.id;
    userName = doc.get('userName');
    email = doc.get('email');
    phone = doc.get('phone');
    socialMedia = doc.get('socialMedia');
    birthday = doc.get('birthday');
    image = doc.get('image');
  }
}
