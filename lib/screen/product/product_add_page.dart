import 'dart:io';

import 'package:compras_full/models/product/product.dart';
import 'package:compras_full/models/product/product_service.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class ItemAddPage extends StatefulWidget {
  ItemAddPage(
      {Key? key,
      this.id,
      this.name,
      this.unit,
      this.price,
      this.image,
      this.active})
      : super(key: key);

  String? id;
  String? name;
  String? unit;
  String? price;
  String? image;
  bool? active;

  @override
  State<ItemAddPage> createState() => _ItenAddPageState();
}

class _ItenAddPageState extends State<ItemAddPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File? _pickedImage;
  Uint8List webImage = Uint8List(8);
  final Produt _itenmain = Produt();
  late final String fileName;
  late File imageFile;
  // ignore: prefer_typing_uninitialized_variables
  var imageSel;

  @override
  void initState() {
    super.initState();
    if (widget.active != null) {
      _itenmain.active = widget.active;
    }

    if (widget.image != null) {
      imageSel = widget.image;
      _pickedImage = File(imageSel);
      webImage = Uint8List(imageSel);
      _itenmain.image = widget.image;
    }

    if (widget.id != null) {
      _itenmain.id = widget.id;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adicionar item"),
        backgroundColor: const Color.fromARGB(255, 114, 7, 7),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 35,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  initialValue: widget.name,
                  decoration: InputDecoration(
                    hintText: 'Produto',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  validator: (sabor) {
                    if (sabor!.isEmpty) {
                      return 'Campo deve ser preenchido!!!';
                    } else if (sabor.trim().split('').length <= 1) {
                      return 'Preencha com seu nome correto';
                    }
                    return null;
                  },
                  onSaved: (sabor) => _itenmain.name = sabor,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  initialValue: widget.unit,
                  decoration: InputDecoration(
                    hintText: 'Unidade',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  validator: (unit) {
                    if (unit!.isEmpty) {
                      return 'Campo deve ser preenchido!!!';
                    }
                    return null;
                  },
                  onSaved: (unit) => _itenmain.unit = unit,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  initialValue: widget.price,
                  decoration: InputDecoration(
                    hintText: 'Preço do produto',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  validator: (price) {
                    if (price!.isEmpty) {
                      return 'Campo deve ser preenchido!!!';
                    }
                    return null;
                  },
                  onSaved: (price) => _itenmain.price = price,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const Text('Ativo'),
                    Checkbox(
                      checkColor: Colors.white,
                      // fillColor: MaterialStateProperty.resolveWith(Colors.blue),
                      value: _itenmain.active ?? true,
                      onChanged: (value) {
                        setState(() {
                          _itenmain.active = value;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width > 650
                      ? 500
                      : MediaQuery.of(context).size.width * 0.90,
                  height: MediaQuery.of(context).size.height > 650
                      ? 350
                      : MediaQuery.of(context).size.height * 0.45,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _pickedImage == null ||
                          webImage.isEmpty && _itenmain.image != null
                      ? dottedBorder(color: Colors.blue)
                      : Card(
                          elevation: 1,
                          color: Theme.of(context).scaffoldBackgroundColor,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: kIsWeb
                                ? Image.memory(webImage)
                                : Image.file(_pickedImage!),
                          ),
                        ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _pickedImage = null;
                    });
                  },
                  child: const Text("Limpar Imagem",
                      style:
                          TextStyle(color: Color.fromARGB(255, 39, 176, 123))),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Cancelar"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          if (kDebugMode) {
                            print('id -> ${_itenmain.id}');
                          }
                          ProductService icecreamService =
                              ProductService(); //chama a regra de salvar
                          if (_itenmain.id == null) {
                            bool ok = await icecreamService.add(
                                itens: _itenmain,
                                imageFile: kIsWeb ? webImage : _pickedImage,
                                plat:
                                    kIsWeb); //passa o objeto para salvar no serviço add
                            if (ok && mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      backgroundColor: Colors.green,
                                      content: Text(
                                          "Dados gravados com sucesso!!!")));
                              _formKey.currentState!.reset();
                              Navigator.of(context).pop();
                            } else {
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(
                                          "Problemas ao gravar dados!!!")));
                            }
                          } else if (_itenmain.id != null) {
                            debugPrint('atualizando');
                            bool ok = await icecreamService.update(
                                itenId: _itenmain.id,
                                itenItem: _itenmain,
                                imageFile: kIsWeb ? webImage : _pickedImage,
                                plat:
                                    kIsWeb); //passa o objeto para salvar no serviço add
                            if (ok && mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      backgroundColor: Colors.green,
                                      content: Text(
                                          "Dados atualizados com sucesso!!!")));
                              _formKey.currentState!.reset();
                              Navigator.of(context).pop();
                            } else {
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(
                                          "Problemas ao atualizar dados!!!")));
                            }
                          }
                        }
                      },
                      child: const Text("Salvar"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dottedBorder({required Color color}) {
    return DottedBorder(
      dashPattern: const [6],
      borderType: BorderType.RRect,
      radius: const Radius.circular(10),
      color: color,
      child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.image_outlined,
                color: color,
                size: 80,
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () {
                    _pickImage();
                  },
                  child: Text(
                    "Escolha uma Imagem para o produto",
                    style: TextStyle(color: color),
                  ))
            ]),
      ),
    );
  }

  Future<void> _pickImage() async {
    if (!kIsWeb) {
      ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var imageSelected = File(image.path);
        setState(() {
          _pickedImage = imageSelected;
        });
      }
    } else if (kIsWeb) {
      ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var imageSelected = await image.readAsBytes();
        setState(() {
          webImage = imageSelected;
          _pickedImage = File('a');
        });
      } else {
        debugPrint('Nenhuma image foi selecionda');
      }
    } else {
      debugPrint('Algo errado aconteceu!');
    }

    //   try {
    //     pickedImage = await picker.pickImage(
    //         source: inputSource == 'camera'
    //             ? ImageSource.camera
    //             : ImageSource.gallery,
    //         maxWidth: 1920);

    //     fileName = path.basename(pickedImage!.path);
    //     imageFile = File(pickedImage.path);

    //     // Refresh the UI
    //     setState(() {});
    //   } catch (err) {
    //     if (kDebugMode) {
    //       print(err);
    //     }
    //   }
  }
}
