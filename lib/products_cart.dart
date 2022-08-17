import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'database/db.dart';
import 'model/products.dart';

class ProductsCart extends StatefulWidget {
  const ProductsCart({Key? key}) : super(key: key);

  @override
  State<ProductsCart> createState() => _ProductsCartState();
}

class _ProductsCartState extends State<ProductsCart> {
  // database
  DB database = DB();

  // Empty list to add all product datas
  List<Map> products = [];
  // List of products from model
  List<Products> items = ProductsList;


  @override
  void initState() {
    database.open();
    getItemsData();
    super.initState();
  }

  void getItemsData() {
    Future.delayed(const Duration(seconds: 1), () async {
      // select all data from database
      products = await database.db!.rawQuery("SELECT * FROM items");
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    num total = products.fold(0, (prev, value) => prev + value["price"]);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("My Cart",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    )),
                Icon(
                  Icons.launch,
                  size: 18,
                )
              ],
            ),
          ),
          cartLists(),
          Container(
            height: 180,
            color: Color.fromARGB(255, 18, 18, 18),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total: ",
                        style: TextStyle(
                          fontSize: 20,
                        )),
                    Text("\$$total",
                        style: const TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 212, 175, 55),
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w600,
                        )),
                  ],
                ),
                Container(
                  height: 40,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 212, 175, 55),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Buy Now",
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget cartLists() {
    return Expanded(
      child: ListView(
        children: products.map((product) {
          var productName =
              items.where((item) => product["name"] == item.name).toList();
          return Slidable(
            endActionPane: ActionPane(
              extentRatio: 0.2,
              motion: const StretchMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) async {
                    await database.db!
                        .rawDelete("DELETE FROM items WHERE id = ?", [
                      product["id"],
                    ]);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.white,
                        content: Text(
                          "Item deleted from the Cart",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    );
                    getItemsData();
                  },
                  backgroundColor: Color.fromARGB(255, 212, 175, 55),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  borderRadius: BorderRadius.circular(12),
                ),
              ],
            ),
            child: Container(
              height: 70,
              width: double.infinity,
              // color: Colors.white,
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: AssetImage("assets/${product["image"]}"),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product["name"],
                          ),
                          Text(
                            "\$${product["price"]}",
                            style: const TextStyle(
                              color: Color.fromARGB(255, 212, 175, 55),
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (productName.first.count <= 1) {
                              return;
                            }
                            productName.first.count--;
                          });
                        },
                        child: Container(
                          height: 17,
                          width: 17,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color.fromARGB(255, 212, 175, 55),
                          ),
                          child: const Icon(
                            Icons.remove,
                            color: Colors.white,
                            size: 15.5,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "${productName.first.count}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            productName.first.count++;
                          });
                        },
                        child: Container(
                          height: 17,
                          width: 17,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color.fromARGB(255, 212, 175, 55),
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 15.5,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
