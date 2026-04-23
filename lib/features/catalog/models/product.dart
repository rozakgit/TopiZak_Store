class Product {
  final String name;
  final List<String> image;
  final int price;
  final double rating;
  final String description;

  Product({
    required this.name,
    required this.image,
    required this.price,
    required this.rating,
    required this.description,
  });
}

List<Product> hatList = [
  Product(
    name: "Adidas Aero Cap",
    image: [
      "assets/image/a1.jpg",
      "assets/image/a2.jpg",
      "assets/image/a3.jpg",
    ],
    price: 150000,
    rating: 4.5,
    description:
    "Topi dari brand Adidas dengan desain sporty dan teknologi breathable. Cocok untuk aktivitas outdoor maupun gaya kasual modern.",
  ),

  Product(
    name: "Astec Urban Cap",
    image: [
    "assets/image/as1.jpg",
    "assets/image/as2.jpg",
    "assets/image/as3.jpg",
    ],
    price: 130000,
    rating: 4.3,
    description:
    "Astec menghadirkan topi dengan kualitas lokal premium, ringan dan nyaman digunakan sehari-hari dengan gaya simpel dan elegan.",
  ),

  Product(
    name: "Converse Street Cap",
    image: [
      "assets/image/c1.jpg",
      "assets/image/c2.jpg",
      "assets/image/c3.jpg",
    ],
    price: 170000,
    rating: 4.7,
    description:
    "Topi Converse dengan desain streetwear klasik yang ikonik, cocok untuk kamu yang ingin tampil santai namun tetap stylish.",
  ),

  Product(
    name: "Lotto Sport Cap",
    image: [
      "assets/image/l1.jpg",
      "assets/image/l2.jpg",
      "assets/image/l3.jpg",
    ],
    price: 140000,
    rating: 4.4,
    description:
    "Topi Lotto dengan desain sporty dan bahan berkualitas tinggi, cocok untuk olahraga maupun aktivitas harian.",
  ),

  Product(
    name: "Reebok Active Cap",
    image: [
      "assets/image/r1.jpg",
      "assets/image/r2.jpg",
      "assets/image/r3.jpg",
    ],
    price: 160000,
    rating: 4.6,
    description:
    "Reebok menghadirkan topi dengan desain modern dan ergonomis, memberikan kenyamanan maksimal untuk aktivitas aktif.",
  ),

  Product(
    name: "Puma Classic Cap",
    image: [
      "assets/image/p1.jpg",
      "assets/image/p2.jpg",
      "assets/image/p3.jpg",
    ],
    price: 180000,
    rating: 4.8,
    description:
    "Topi Puma dengan desain klasik dan logo khas yang elegan, cocok untuk tampilan sporty dan fashionable.",
  ),

  Product(
    name: "New Balance Casual Cap",
    image: [
      "assets/image/n1.jpg",
      "assets/image/n2.jpg",
      "assets/image/n3.jpg",
    ],
    price: 175000,
    rating: 4.7,
    description:
    "Topi New Balance dengan desain minimalis dan nyaman dipakai, cocok untuk gaya kasual sehari-hari.",
  ),

  // 🔥 TAMBAHAN BARU
  Product(
    name: "Diadora Sport Cap",
    image: [
      "assets/image/d1.jpg",
      "assets/image/d2.jpg",
      "assets/image/d3.jpg",
    ],
    price: 155000,
    rating: 4.5,
    description:
    "Topi Diadora dengan desain sporty khas Italia, ringan dan nyaman digunakan untuk aktivitas olahraga maupun santai.",
  ),

  Product(
    name: "Airwalk Street Cap",
    image: [
      "assets/image/ai1.jpg",
      "assets/image/ai2.jpg",
      "assets/image/ai3.jpg",
    ],
    price: 145000,
    rating: 4.4,
    description:
    "Topi Airwalk dengan gaya streetwear yang kuat dan modern, cocok untuk anak muda yang ingin tampil stylish dan percaya diri.",
  ),
  Product(
    name: "Skechers Street Cap",
    image: [
      "assets/image/s1.jpg",
      "assets/image/s2.jpg",
      "assets/image/s3.jpg",
    ],
    price: 145000,
    rating: 4.4,
    description:
    "Topi Skechers dengan gaya streetwear yang kuat dan modern, cocok untuk anak muda yang ingin tampil stylish dan percaya diri.",
  ),
];