import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:statemanagement/models/dummy_model.dart';
import 'package:statemanagement/pages/dummy/dummy_detail_screen.dart';
import 'package:statemanagement/pages/dummy/dummy_detail_screen.dart'; // perbaiki titik ganda

const kPrimaryColor = Color(0xFF6C63FF);

class ListQummyScreen extends StatefulWidget {
  const ListQummyScreen({super.key});

  @override
  State<ListQummyScreen> createState() => _ListQummyScreenState();
}

class _ListQummyScreenState extends State<ListQummyScreen> {
  late Future<List<DummyProduct>> _futureProducts;

  Future<List<DummyProduct>> fetchProducts() async {
    final response =
        await http.get(Uri.parse('https://dummyjson.com/products'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List products = data['products'];
      return products.map((e) => DummyProduct.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  void initState() {
    super.initState();
    _futureProducts = fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor.withOpacity(0.04),
      appBar: AppBar(
        title: const Text('Dummy Product List'),
        backgroundColor: kPrimaryColor,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<List<DummyProduct>>(
        future: _futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(color: kPrimaryColor));
          }
          if (snapshot.hasError) {
            return Center(
                child: Text('Error: ${snapshot.error}',
                    style: const TextStyle(color: Colors.red)));
          }
          final products = snapshot.data ?? [];
          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 kolom
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.72,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final p = products[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => DummyDetailScreen(product: p)),
                  );
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: kPrimaryColor.withOpacity(0.12),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Bagian Gambar
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(18)),
                            child: Image.network(
                              p.thumbnail,
                              height: 150,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, progress) =>
                                  progress == null
                                      ? child
                                      : const Center(
                                          child: CircularProgressIndicator(
                                              color: kPrimaryColor)),
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                height: 150,
                                color: Colors.grey[200],
                                child: const Icon(Icons.broken_image, size: 60),
                              ),
                            ),
                          ),
                          if (p.discountPercentage > 0)
                            Positioned(
                              top: 8,
                              left: 8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  '-${p.discountPercentage}% OFF',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ),
                            ),
                        ],
                      ),
                      // Bagian Detail
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              p.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: kPrimaryColor),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              p.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.black54),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Text(
                                  '\$${p.price}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: kPrimaryColor),
                                ),
                                const SizedBox(width: 6),
                                if (p.discountPercentage > 0)
                                  Text(
                                    '\$${(p.price / (1 - p.discountPercentage / 100)).toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(Icons.star,
                                    color: Colors.amber[700], size: 14),
                                const SizedBox(width: 2),
                                Text(
                                  p.rating.toString(),
                                  style: const TextStyle(fontSize: 12),
                                ),
                                const Spacer(),
                                Icon(Icons.inventory_2,
                                    color: kPrimaryColor, size: 14),
                                const SizedBox(width: 2),
                                Text(
                                  p.stock.toString(),
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
