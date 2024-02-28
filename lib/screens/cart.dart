import 'package:flutter/material.dart';
import 'package:mini_e_commerce/config.dart';
import 'package:mini_e_commerce/global_variable.dart';
import 'package:mini_e_commerce/Providers/cart_provider.dart';
import 'package:provider/provider.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> cart = Provider.of<CartProvider>(context).cart;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cart'),
        ),
        body: cart.length > 0
            ? ListView.builder(
                itemCount: cart.length,
                itemBuilder: (context, index) {
                  final product = cart[index];
                  return ListTile(
                    title: Text(
                      product['title'] as String,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("size : ${product['size'].toString()}"),
                    leading: CircleAvatar(
                      radius: 30,
                      child: Image.asset(product['imageUrl'].toString()),
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  icon: const Icon(Icons.change_circle),
                                  title: const Text("Delete product"),
                                  content: const Text(
                                      "Are you sure to delete this product from your card?"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('No',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Config.primaryColor))),
                                    TextButton(
                                        onPressed: () {
                                          Provider.of<CartProvider>(context,
                                                  listen: false)
                                              .removeProductInCart(product);
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('yes',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red)))
                                  ],
                                );
                              });
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        )),
                  );
                })
            : const Center(
                child: Text(
                  "Your cart is empty",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromRGBO(255, 0, 0, 0.87),
                  ),
                ),
              ));
  }
}
