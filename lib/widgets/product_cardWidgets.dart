import 'package:api/models/productModel.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final Data product;
  const ProductCard({
    super.key,
    required this.product,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        // ✅ Fixed height to prevent overflow
        height: 220, // Adjust this value if needed
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // Full width
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.network(
                "${product.img}",
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(height: 5),

            // Product Details
            Text(
              "${product.productName}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
            Text(
              'Price: ${product.totalPrice} | QTY: ${product.qty}',
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),

            Spacer(),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed:onEdit,
                  icon: Icon(Icons.edit, color: Colors.orange, size: 20),
                ),
                IconButton(
                  onPressed: onDelete,
                  icon: Icon(Icons.delete, color: Colors.red, size: 20),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
