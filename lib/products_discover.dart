import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_home_products/products_details.dart';

import 'model/products.dart';

class HomeProductsDiscover extends StatefulWidget {
  const HomeProductsDiscover({Key? key}) : super(key: key);

  @override
  State<HomeProductsDiscover> createState() => _HomeProductsDiscoverState();
}

class _HomeProductsDiscoverState extends State<HomeProductsDiscover>
    with TickerProviderStateMixin {
  // Text editing controller
  late final TabController _tabController = TabController(
    length: 4,
    vsync: this,
  );
  // List of products from model
  List<Products> products = ProductsList;
  var searchProducts;

  @override
  void initState() {
    searchProducts = List.from(products);
    super.initState();
  }

  void filterProducts(String value) {
    setState(() {
      searchProducts = products.where((product) {
        String productName = product.name.toLowerCase();
        String userEntry = value.toLowerCase();
        return productName.contains(userEntry);
      }).toList();
      print(searchProducts);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            lampHomeAppBar(),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  labelPadding: EdgeInsets.only(right: 15),
                  indicatorColor: Colors.transparent,
                  unselectedLabelColor: Colors.white38,
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  tabs: [
                    tabContainer("Lamp"),
                    tabContainer("Chair"),
                    tabContainer("Bed"),
                    tabContainer("Sofa"),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                    height: 490,
                    width: double.infinity,
                    // color: Colors.white,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        discoverLists("triangle"),
                        discoverLists("chair"),
                        discoverLists("bed"),
                        discoverLists("sofa"),
                      ],
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget discoverLists(String item) {
    var productsList =
        searchProducts.where((product) => product.type == item).toList();

    return MediaQuery.removePadding(
      context: context,
      removeBottom: true,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 5 / 8,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
        ),
        itemCount: productsList.length,
        itemBuilder: (context, index) {
          final product = productsList[index];
          return Container(
            // color: Colors.yellow,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 170,
                  padding: const EdgeInsets.all(12),
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.shade300,
                    image: DecorationImage(
                      image: AssetImage("assets/${product.image}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        product.isFavorite = !product.isFavorite;
                      });
                    },
                    child: CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.grey.shade200,
                      child: product.isFavorite
                          ? const Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 16,
                            )
                          : const Icon(
                              Icons.favorite_outline,
                              size: 16,
                            ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              ProductsDetails(product: product)));
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.transparent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            product.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "\$${product.price}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 212, 175, 55),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget tabContainer(String item) => Container(
        height: 32,
        width: 70,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color.fromARGB(255, 212, 175, 55),
        ),
        child: Text(
          item,
        ),
      );

  Widget lampHomeAppBar() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Discover",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 25,
            ),
          ),
          Row(
            children: [
              Container(
                height: 28,
                width: 160,
                // color: Colors.yellow,
                child: TextField(
                  style: const TextStyle(
                    fontSize: 13,
                    letterSpacing: 1,
                  ),
                  onChanged: (value) => filterProducts(value),
                  cursorColor: Colors.white,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(
                      Icons.search,
                      size: 20,
                    ),
                    contentPadding: EdgeInsets.only(
                      left: 8,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Icon(
                Icons.shopping_bag_outlined,
                size: 20,
              ),
            ],
          ),
        ],
      );
}
