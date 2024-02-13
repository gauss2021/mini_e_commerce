import "package:flutter/material.dart";

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
        title: const Text('Detail'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.product['title'] as String, style: Config.largeText),
          Image.asset(
            widget.product['imageUrl'] as String,
            height: 200,
          ),
          Container(
            padding: const EdgeInsets.all(12),
            width: double.infinity,
            height: 200,
            decoration: const BoxDecoration(color: Colors.blueGrey),
            child: Column(
              children: [
                Text("${widget.product['price'] as String} FCFA",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
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
                                    ? Config.primaryColor
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
                  label: const Text("Add to cart"),
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: () {},
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Config.primaryColor),
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
