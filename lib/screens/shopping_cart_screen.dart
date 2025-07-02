import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ShoppingCartScreen extends StatefulWidget {
  final List<Map<String, String>> cartItems;

  const ShoppingCartScreen({super.key, required this.cartItems});

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  late Map<String, int> itemQuantities;

  @override
  void initState() {
    super.initState();
    itemQuantities = {for (var item in widget.cartItems) item['name']!: 1};
  }

  double _calculateSubtotal() {
    double subtotal = 0.0;
    for (var item in widget.cartItems) {
      double price = double.parse(
        item['price']!.replaceAll('Rp. ', '').replaceAll('.', ''),
      );
      int quantity = itemQuantities[item['name']!] ?? 1;
      subtotal += price * quantity;
    }
    return subtotal;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Shopping Cart',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              'assets/logo_step_over.png',
              color: Colors.grey[200],
              width: 250,
            ),
          ),
          // Konten utama
          Column(
            children: [
              Expanded(
                child:
                    widget.cartItems.isEmpty
                        ? Center(
                          child: Text(
                            "Your cart is empty.",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        )
                        : ListView.builder(
                          padding: const EdgeInsets.all(16.0),
                          itemCount: widget.cartItems.length,
                          itemBuilder: (context, index) {
                            final item = widget.cartItems[index];
                            return _buildCartItem(item);
                          },
                        ),
              ),
              // Bagian Subtotal
              _buildSubtotal(),
            ],
          ),
        ],
      ),
      bottomNavigationBar: _buildPlaceOrderButton(),
    );
  }

  // Widget untuk setiap item di keranjang
  Widget _buildCartItem(Map<String, String> item) {
    String itemName = item['name']!;
    int quantity = itemQuantities[itemName]!;
    String selectedSize = item['selectedSize'] ?? 'N/A';

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Gambar Produk
            Image.asset(
              item['image']!,
              width: 80,
              height: 80,
              errorBuilder:
                  (context, error, stackTrace) =>
                      const Icon(Icons.image_not_supported),
            ),
            const SizedBox(width: 16),
            // Info Produk
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Nike",
                    style: GoogleFonts.poppins(color: Colors.grey[600]),
                  ),
                  Text(
                    itemName,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "Size: $selectedSize",
                    style: GoogleFonts.poppins(
                      color: Colors.grey[700],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item['price']!,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            _buildQuantityStepper(itemName, quantity),
          ],
        ),
      ),
    );
  }

  // Widget untuk menaikkan/menurunkan jumlah item
  Widget _buildQuantityStepper(String itemName, int quantity) {
    return Row(
      children: [
        // Tombol Kurang
        InkWell(
          onTap: () {
            if (quantity > 1) {
              setState(() {
                itemQuantities[itemName] = quantity - 1;
              });
            }
          },
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.red[800],
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.remove, color: Colors.white, size: 16),
          ),
        ),
        // Jumlah
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            quantity.toString(),
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        // Tombol Tambah
        InkWell(
          onTap: () {
            setState(() {
              itemQuantities[itemName] = quantity + 1;
            });
          },
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.red[800],
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.add, color: Colors.white, size: 16),
          ),
        ),
      ],
    );
  }

  // Widget untuk menampilkan subtotal
  Widget _buildSubtotal() {
    double subtotal = _calculateSubtotal();

    final currencyFormatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp.',
      decimalDigits: 0,
    );
    String formattedSubtotal = currencyFormatter.format(subtotal);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Subtotal",
            style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[700]),
          ),
          Text(
            formattedSubtotal,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk tombol Place Order
  Widget _buildPlaceOrderButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: const Color(0xff8D2B2B),
      child: ElevatedButton(
        onPressed: () {
          if (widget.cartItems.isNotEmpty) {
            double subtotal = _calculateSubtotal();
            Navigator.pushNamed(
              context,
              '/payment',
              arguments: {'subtotal': subtotal, 'cartItems': widget.cartItems},
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Your cart is empty!'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.yellow[700],
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Text(
          "Place Order",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
