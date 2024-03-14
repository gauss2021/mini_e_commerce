import 'package:flutter/material.dart';
import 'package:mini_e_commerce/components/card_product.dart';
import 'package:mini_e_commerce/config.dart';
import 'package:mini_e_commerce/screens/detail_product_page.dart';
import './../global_variable.dart';

class ProductsList extends StatefulWidget {
  const ProductsList({super.key});

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  final List<String> brands = ['All', 'Addidas', 'Nike', 'Puma', 'New Balance'];
  int currentIndex = 0;

  TextEditingController searchEditingController = TextEditingController();

  List<Map<String, Object>> filterProduct = [];

  late List<String> selectedBrand;

  // Function to filter products based on brand
  List<Map<String, Object>> filterProductsByBrand(String brand) {
    return products.where((product) => product['brand'] == brand).toList();
  }

  List<Map<String, Object>> filterProductsByName(String query) {
    List<Map<String, Object>> filteredList = [];
    if (query.isNotEmpty) {
      for (var product in products) {
        String title = product['title'].toString().toLowerCase();
        if (title.contains(query.toLowerCase())) {
          filteredList.add(product);
        }
      }
    }

    return filteredList;
  }

  @override
  void dispose() {
    super.dispose();
    searchEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "Shopping \n Collection",
                style: TextStyle(
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
            ),
            Expanded(
              child: TextField(
                onChanged: (text) {
                  print(text);
                  setState(() {
                    filterProduct = filterProductsByName(text);
                    print(filterProduct);
                  });
                },
                controller: searchEditingController,
                decoration: const InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30)),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromRGBO(0, 0, 0, 0.6)),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            bottomLeft: Radius.circular(30)))),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: SizedBox(
            height: 50,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: brands.length,
                itemBuilder: (context, index) {
                  String brandLabel = brands[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: GestureDetector(
                      onTap: () => {
                        setState(() {
                          currentIndex = index;

                          //On filtre la valeur de product

                          filterProduct = filterProductsByBrand(brandLabel);
                          print(filterProduct);
                        })
                      },
                      child: Chip(
                        backgroundColor: index == currentIndex
                            ? Config.secondaryColor
                            : null,
                        label: Text(brandLabel),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                    ),
                  );
                }),
          ),
        ),

        //Display selected product

        const SizedBox(
          height: 12,
        ),
        Expanded(
          child: ListView.builder(
              itemCount:
                  currentIndex == 0 ? products.length : filterProduct.length,
              itemBuilder: (context, index) {
                final Map<String, Object> currentProduct =
                    currentIndex == 0 ? products[index] : filterProduct[index];

                return GestureDetector(
                  onTap: () {
                    print('On a clique sur un produit');
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return DetailProductPage(product: currentProduct);
                    }));
                  },
                  child: CardProduct(
                      price: currentProduct['price'] as String,
                      title: currentProduct['title'] as String,
                      imageUrl: currentProduct['imageUrl'] as String),
                );
              }),
        )
      ],
    ));
  }
}
