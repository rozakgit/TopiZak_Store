import 'package:flutter/material.dart';
import '../models/product.dart';
import 'detail_page.dart';
import '../widgets/product_card.dart'; // 🔥 pakai card yang sama
import '../../profile/pages/chat_page.dart';

class StorePage extends StatefulWidget {
  final String storeName;

  const StorePage({super.key, required this.storeName});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  String selectedCategory = "Semua";

  // 🔥 FILTER PRODUK
  List<Product> getStoreProducts() {
    return hatList.where((product) {
      final matchStore =
      product.name.contains(widget.storeName.split(" ")[0]);

      if (selectedCategory == "Semua") return matchStore;

      return matchStore &&
          product.name.toLowerCase().contains(selectedCategory.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final products = getStoreProducts();

    return Scaffold(
      appBar: AppBar(title: Text(widget.storeName)),

      body: Column(
        children: [
          // 🏪 HEADER TOKO
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.grey[200],
                  child: Icon(Icons.store, size: 35),
                ),
                SizedBox(height: 10),

                Text(
                  widget.storeName,
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),

                Text("Official Store"),

                SizedBox(height: 10),

                // ⭐ RATING TOKO
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star, color: Colors.orange),
                    SizedBox(width: 5),
                    Text("4.8"),
                    SizedBox(width: 5),
                    Text("(1.2K reviews)",
                        style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatPage(
                        storeName: widget.storeName,
                      ),
                    ),
                  );
                },
                icon: Icon(Icons.chat),
                label: Text("Chat Seller"),
              ),
            ],
          ),

          Divider(),

          // 🏷️ KATEGORI
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 10),
              children: [
                buildCategory("Semua"),
                buildCategory("Cap"),
                buildCategory("Hat"),
                buildCategory("Snapback"),
              ],
            ),
          ),

                    // 🧢 PRODUK (PAKAI PRODUCT CARD)
          Expanded(
            child: products.isEmpty
                ? Center(child: Text("Produk tidak ditemukan"))
                : GridView.builder(
              padding: EdgeInsets.all(10),
              itemCount: products.length,
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                return ProductCard(product: products[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  // 🔥 WIDGET CATEGORY
  Widget buildCategory(String category) {
    final isSelected = selectedCategory == category;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = category;
        });
      },
      child: Container(
        margin: EdgeInsets.only(right: 8),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.orange : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          category,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}