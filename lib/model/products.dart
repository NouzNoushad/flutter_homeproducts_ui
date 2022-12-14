import 'package:flutter/material.dart';

class Products {
  final String image, name, type, color;
  final int price;
  int count;
  bool isFavorite;
  double rating;
  Color colors;

  Products({
    required this.image,
    required this.name,
    required this.type,
    required this.color,
    required this.price,
    required this.rating,
    required this.count,
    required this.isFavorite,
    required this.colors,
  });
}

final ProductsList = [
  Products(
    image: "triangle_black.jpg",
    name: "Black Lamp",
    type: "triangle",
    color: "black",
    count: 1,
    price: 280,
    rating: 3.5,
    colors: Colors.black,
    isFavorite: false,
  ),
  Products(
    image: "triangle_oak.jpg",
    name: "Oak Lamp",
    type: "triangle",
    color: "oak",
    count: 1,
    rating: 3.8,
    colors: const Color.fromARGB(255, 142, 99, 84),
    price: 285,
    isFavorite: false,
  ),
  Products(
    image: "triangle_purple.jpg",
    name: "Purple Lamp",
    type: "triangle",
    color: "purple",
    count: 1,
    rating: 4.2,
    colors: Colors.purple,
    price: 270,
    isFavorite: false,
  ),
  Products(
    image: "triangle_ochre.jpg",
    name: "Ochre Lamp",
    type: "triangle",
    color: "ochre",
    count: 1,
    rating: 4.6,
    colors: const Color.fromARGB(255, 204, 119, 34),
    price: 290,
    isFavorite: false,
  ),
  Products(
    image: "chair_yellow.jpg",
    name: "Yellow Chair",
    type: "chair",
    color: "yellow",
    count: 1,
    rating: 4.2,
    colors: Color.fromARGB(255, 255, 212, 83),
    price: 330,
    isFavorite: false,
  ),
  Products(
    image: "chair_maroon.jpg",
    name: "Maroon Chair",
    type: "chair",
    color: "maroon",
    count: 1,
    rating: 4.5,
    colors: Color.fromARGB(255, 138, 25, 25),
    price: 350,
    isFavorite: false,
  ),
  Products(
    image: "chair_camel.jpg",
    name: "Camel Chair",
    type: "chair",
    color: "camel",
    count: 1,
    rating: 4.9,
    colors: Color.fromARGB(255, 185, 108, 13),
    price: 380,
    isFavorite: false,
  ),
  Products(
    image: "chair_grey.jpg",
    name: "Grey Chair",
    type: "chair",
    color: "grey",
    count: 1,
    rating: 3.8,
    colors: Colors.grey,
    price: 376,
    isFavorite: false,
  ),
  Products(
    image: "bed_blue.jpg",
    name: "Blue Bed",
    type: "bed",
    color: "blue",
    count: 1,
    rating: 3.9,
    colors: Colors.blue,
    price: 450,
    isFavorite: false,
  ),
  Products(
    image: "bed_red.jpg",
    name: "Red Bed",
    type: "bed",
    color: "red",
    count: 1,
    rating: 4.1,
    colors: Colors.red,
    price: 470,
    isFavorite: false,
  ),
  Products(
    image: "bed_brown.jpg",
    name: "Brown Bed",
    type: "bed",
    color: "brown",
    count: 1,
    rating: 4,
    colors: Colors.brown,
    price: 455,
    isFavorite: false,
  ),
  Products(
    image: "bed_purple.jpg",
    name: "Purple Bed",
    type: "bed",
    color: "purple",
    count: 1,
    rating: 4.7,
    colors: Colors.purple,
    price: 468,
    isFavorite: false,
  ),
  Products(
    image: "sofa_green.jpg",
    name: "Green Sofa",
    type: "sofa",
    color: "green",
    count: 1,
    rating: 4.8,
    colors: const Color.fromARGB(255, 13, 152, 186),
    price: 550,
    isFavorite: false,
  ),
  Products(
    image: "sofa_yellow.jpg",
    name: "Yellow Sofa",
    type: "sofa",
    color: "yellow",
    count: 1,
    rating: 3.4,
    colors: Colors.yellow,
    price: 570,
    isFavorite: false,
  ),
  Products(
    image: "sofa_dark_green.jpg",
    name: "Dark Sofa",
    type: "sofa",
    color: "dark_green",
    count: 1,
    rating: 4.8,
    colors: Color.fromARGB(255, 8, 99, 122),
    price: 580,
    isFavorite: false,
  ),
  Products(
    image: "sofa_gray.jpg",
    name: "Grey Sofa",
    type: "sofa",
    color: "gray",
    count: 1,
    rating: 3.8,
    colors: Colors.grey,
    price: 560,
    isFavorite: false,
  ),
];
