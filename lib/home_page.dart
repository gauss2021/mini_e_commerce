import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> brands = ['All', 'Addidas', 'Nike', 'Puma', 'New Balance'];
  int currentIndex = 0;

  late List<String> selectedBrand;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          SizedBox(
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
                          print('element $index');
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

          //Display selected product

          const SizedBox(
            height: 12,
          ),
          SizedBox(
            height: 100,
            child: ListView.builder(
                itemCount: currentIndex == 0 ? brands.length - 1 : 1,
                itemBuilder: (context, index) {
                  if (currentIndex == 0) {
                    String displayBrand = brands[index + 1];
                    return Text(displayBrand);
                  } else {
                    String displayBrand = brands[currentIndex];
                    return Text(displayBrand);
                  }
                }),
          )
        ],
      )),
    );
  }
}
