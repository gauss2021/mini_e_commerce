import "package:flutter/material.dart";
import 'package:mini_e_commerce/Providers/cart_provider.dart';
import 'package:provider/provider.dart';

import './../config.dart';

class DetailProductPage extends StatefulWidget {
  final Map<String, Object> product;

  const DetailProductPage({super.key, required this.product});

  @override
  State<DetailProductPage> createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  List selectedSize = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Config.lessPrimaryColor,
        title: Text('Detail', style: Config.mediumText),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.product['title'] as String,
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color.fromRGBO(0, 0, 0, 0.87))),
          Image.asset(
            widget.product['imageUrl'] as String,
            height: 200,
          ),
          Container(
            padding: const EdgeInsets.all(12),
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(color: Config.lessPrimaryColor),
            child: Column(
              children: [
                Text("${widget.product['price'] as String} FCFA",
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: (widget.product['sizes'] as List).length,
                      itemBuilder: (context, index) {
                        int size = ((widget.product['sizes'] as List)[index]);

                        return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () => {
                                if (selectedSize.contains(size))
                                  {
                                    setState(() {
                                      selectedSize.remove(size);
                                    })
                                  }
                                else
                                  {
                                    setState(() {
                                      selectedSize.add(size);
                                    })
                                  }
                              },
                              child: Chip(
                                backgroundColor: selectedSize.contains(size)
                                    ? Config.secondaryColor
                                    : null,
                                label: Text("$size"),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ));
                      }),
                ),
                const SizedBox(
                  height: 12,
                ),
                ElevatedButton.icon(
                  label: const Text("Add to cart",
                      style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.87),
                      )),
                  icon: const Icon(Icons.shopping_cart,
                      color: Color.fromRGBO(255, 255, 255, 0.87)),
                  onPressed: () {
                    if (selectedSize.isNotEmpty) {
                      for (int i = 0; i < selectedSize.length; i++) {
                        final Map<String, dynamic> newProduct = {
                          'id': widget.product['id'],
                          'title': widget.product['title'],
                          'price': widget.product['price'],
                          'size': selectedSize[i],
                          'brand': widget.product['brand'],
                          'imageUrl': widget.product['imageUrl']
                        };

                        Provider.of<CartProvider>(context, listen: false)
                            .addProductInCart(newProduct);
                      }

                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              "Votre produit a bien ete ajoute au panier")));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content:
                              Text("Vous n'avez pas selectionner de taille")));
                    }
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Config.secondaryColor),
                      minimumSize: const MaterialStatePropertyAll(
                          Size(double.infinity, 40))),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
