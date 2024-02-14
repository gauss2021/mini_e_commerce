import 'package:flutter/material.dart';
import 'package:mini_e_commerce/components/card_product.dart';
import 'package:mini_e_commerce/global_variable.dart';
import 'package:mini_e_commerce/screens/detail_product_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> brands = ['All', 'Addidas', 'Nike', 'Puma', 'New Balance'];
  int currentIndex = 0;

  late List<String> selectedBrand;

  int currentIndexOfBottomNavigationBar = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndexOfBottomNavigationBar,
          onTap: (value) {
            setState(() {
              currentIndexOfBottomNavigationBar = value;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: '')
          ]),
      body: SafeArea(
          child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
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
                  decoration: InputDecoration(
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
                          })
                        },
                        child: Chip(
                          backgroundColor:
                              index == currentIndex ? Colors.amber : null,
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
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final Map<String, Object> currentProduct = products[index];

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
      )),
    );
  }
}
