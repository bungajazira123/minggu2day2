import 'package:flutter/material.dart';
import 'package:statemanagement/models/dummy_model.dart';

const kPrimaryColor = Color(0xFF6C63FF); // Samakan dengan login/register

class DummyDetailScreen extends StatelessWidget {
  final DummyProduct product;
  const DummyDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor.withOpacity(0.04),
      appBar: AppBar(
        title: Text(product.title),
        backgroundColor: kPrimaryColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Carousel Images dengan badge diskon
            Stack(
              children: [
                SizedBox(
                  height: 240,
                  child: PageView.builder(
                    itemCount: product.images.length,
                    itemBuilder: (context, index) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 400),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 18),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: kPrimaryColor.withOpacity(0.18),
                              blurRadius: 16,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            product.images[index],
                            fit: BoxFit.cover,
                            width: double.infinity,
                            loadingBuilder: (context, child, progress) =>
                                progress == null
                                    ? child
                                    : Center(
                                        child: CircularProgressIndicator(
                                            color: kPrimaryColor)),
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                              color: Colors.grey[200],
                              child: const Icon(Icons.broken_image, size: 60),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                if (product.discountPercentage > 0)
                  Positioned(
                    top: 28,
                    left: 28,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.redAccent.withOpacity(0.2),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: Text(
                        '-${product.discountPercentage}% OFF',
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.title,
                          style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor)),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Chip(
                            label: Text(product.brand,
                                style: const TextStyle(color: kPrimaryColor)),
                            backgroundColor: kPrimaryColor.withOpacity(0.08),
                          ),
                          const SizedBox(width: 8),
                          Chip(
                            label: Text(product.category,
                                style: const TextStyle(color: kPrimaryColor)),
                            backgroundColor: kPrimaryColor.withOpacity(0.08),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Text(
                        product.description,
                        style: const TextStyle(
                            fontSize: 16, color: Colors.black87),
                      ),
                      const SizedBox(height: 18),
                      Row(
                        children: [
                          Text(
                            '\$${product.price}',
                            style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor),
                          ),
                          const SizedBox(width: 16),
                          if (product.discountPercentage > 0)
                            Text(
                              '\$${(product.price / (1 - product.discountPercentage / 100)).toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber[700], size: 22),
                          Text(
                            '${product.rating}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 18),
                          Icon(Icons.inventory_2,
                              color: kPrimaryColor, size: 22),
                          Text(
                            'Stock: ${product.stock}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      // Tombol dihapus, jadi tidak ada ElevatedButton.icon di sini
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
