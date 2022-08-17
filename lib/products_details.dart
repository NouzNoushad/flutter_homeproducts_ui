import 'package:flutter/material.dart';
// flutter star rating package
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'database/db.dart';
import 'model/products.dart';

class ProductsDetails extends StatefulWidget {
  final Products product;
  const ProductsDetails({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductsDetails> createState() => _ProductsDetailsState();
}

class _ProductsDetailsState extends State<ProductsDetails> {
  // initializing new product data
  String? newType, newColor, newName;
  int? newPrice;
  double? newRating;

  // Database
  DB database = DB();
  // List of products from model
  List<Products> allProducts = ProductsList;

  @override
  void initState() {
    // assigning all products datas into new data
    newColor = widget.product.color;
    newName = widget.product.name;
    newPrice = widget.product.price;
    newRating = widget.product.rating;
    database.open();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    // filter out products data using type.
    List items =
        allProducts.where((product) => product.type == newType).toList();
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        child: Stack(
          children: [
            Container(
              height: height / 2,
              width: width,
              padding: const EdgeInsets.all(15),
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      "assets/${newType}_$newColor.jpg",
                    ),
                    fit: BoxFit.cover),
              ),
              child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.arrow_back, color: Colors.black)),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: height / 2 + 15,
                width: width,
                padding: const EdgeInsets.fromLTRB(20, 45, 20, 20),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Colors.black,
                ),
                child: productDetails(items),
              ),
            ),
            Positioned(
              top: height / 2 - 35,
              right: 20,
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.pink.shade200,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      // toggling true false condition
                      widget.product.isFavorite = !widget.product.isFavorite;
                    });
                  },
                  child: widget.product.isFavorite
                      ? const Icon(
                          Icons.favorite,
                          size: 22,
                          color: Colors.red,
                        )
                      : const Icon(
                          Icons.favorite,
                          size: 22,
                          color: Colors.white,
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget productDetails(List items) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          newName!,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "\$$newPrice",
              style: const TextStyle(
                color: Color.fromARGB(255, 212, 175, 55),
                fontSize: 22,
                letterSpacing: 1,
                fontWeight: FontWeight.w700,
              ),
            ),
            Container(
              height: 30,
              width: 160,
              // color: Colors.white,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        newType = item.type;
                        newColor = item.color;
                        newName = item.name;
                        newPrice = item.price;
                        newRating = item.rating;
                      });
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        border:
                            Border.all(width: 2, color: Colors.grey.shade200),
                        shape: BoxShape.circle,
                        color: item.colors,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        Row(
          children: [
            RatingBar.builder(
              initialRating: newRating!,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 18,
              onRatingUpdate: (rating) {
                setState(() {
                  newRating = rating;
                });
              },
              itemBuilder: (context, _) {
                return const Icon(Icons.star,
                    color: Color.fromARGB(255, 212, 175, 55));
              },
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "$newRating",
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 212, 175, 55),
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Description",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "Lorem ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text.",
              style: TextStyle(
                fontSize: 12.5,
                color: Colors.grey,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        Container(
          height: 40,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              await database.db!.rawInsert(
                  "INSERT INTO items (image, name, price, count) VALUES (?, ?, ?, ?);",
                  [
                    "${newType}_$newColor.jpg",
                    newName,
                    newPrice,
                    widget.product.count,
                  ]);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.white,
                  content: Text(
                    "New item added to Cart",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(255, 212, 175, 55),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              "Add to Cart",
            ),
          ),
        ),
      ],
    );
  }
}
