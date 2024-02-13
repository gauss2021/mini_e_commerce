import 'package:flutter/material.dart';
import 'package:mini_e_commerce/config.dart';

class CardProduct extends StatelessWidget {
  final String title;

  final String price;

  final String imageUrl;

  const CardProduct(
      {super.key,
      required this.price,
      required this.title,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      padding: const EdgeInsets.all(16),
      height: 250,
      decoration: BoxDecoration(
        color: Config.primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Config.largeText,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            "$price FCFA ",
            style: Config.smallText,
          ),
          const SizedBox(
            height: 8,
          ),
          Center(
            child: Image.asset(
              imageUrl,
              height: 140,
            ),
          )
        ],
      ),
    );
  }
}
