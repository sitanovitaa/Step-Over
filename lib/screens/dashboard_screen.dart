import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'product_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _pageIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchBar(),
              const SizedBox(height: 20),
              _buildFlashSaleBanner(),
              const SizedBox(height: 10),
              _buildPageIndicator(),
              const SizedBox(height: 20),
              _buildSectionHeader("Categories"),
              const SizedBox(height: 10),
              _buildCategoryList(),
              const SizedBox(height: 20),
              _buildSectionHeader("Popular Deals"),
              const SizedBox(height: 10),
              _buildPopularDealsList(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  // Widget untuk Search Bar
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search brand, shoes....',
          hintStyle: GoogleFonts.poppins(color: Colors.white70),
          prefixIcon: const Icon(Icons.search, color: Colors.white70),
          suffixIcon: IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.white70),
            onPressed: () {},
          ),
          filled: true,
          fillColor: const Color(0xff8D2B2B),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
        ),
      ),
    );
  }

  // Widget untuk Banner Flash Sale
  Widget _buildFlashSaleBanner() {
    return SizedBox(
      height: 150,
      child: PageView.builder(
        controller: _pageController,
        itemCount: 3,
        onPageChanged: (index) {
          setState(() {
            _pageIndex = index;
          });
        },
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                colors: [
                  const Color(0xffB93B3B).withOpacity(0.8),
                  const Color(0xff8D2B2B),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.flash_on, color: Colors.yellow, size: 50),
                const SizedBox(height: 8),
                Text(
                  "FLASH SALE",
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "CHECK IT OUT!!!",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Indikator halaman untuk banner
  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                _pageIndex == index
                    ? const Color(0xff8D2B2B)
                    : Colors.grey[400],
          ),
        );
      }),
    );
  }

  // Widget untuk header setiap seksi (Categories, Popular Deals)
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Color(0xff8D2B2B),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }

  // Placeholder data produk
  final List<Map<String, String>> categoryProducts = [
    {
      "image": "assets/shoe1.png",
      "name": "Nike G.T. Hustle 2",
      "price": "Rp. 2.849.000",
    },
    {
      "image": "assets/shoe2.png",
      "name": "Asics Novablast 5",
      "price": "Rp. 2.849.000",
    },
    {
      "image": "assets/shoe3.png",
      "name": "Adidas Adizero Adios",
      "price": "Rp. 2.100.000",
    },
    {
      "image": "assets/shoe4.jpg",
      "name": "Ortuseight Hyperblast 2.0",
      "price": "Rp. 1.249.000",
    },
  ];

  final List<Map<String, String>> popularProducts = [
    {
      "image": "assets/shoe5.png",
      "name": "Under Armour Curry 12",
      "price": "Rp. 1.950.000",
    },
    {
      "image": "assets/shoe6.png",
      "name": "Puma Mb.04 Gem",
      "price": "Rp. 1.720.000",
    },
  ];

  // Widget untuk daftar kategori
  Widget _buildCategoryList() {
    return _buildProductList(categoryProducts);
  }

  // Widget untuk daftar popular deals
  Widget _buildPopularDealsList() {
    return _buildProductList(popularProducts, cardWidth: 180, imageHeight: 120);
  }

  // Widget generik untuk daftar produk horizontal
  Widget _buildProductList(
    List<Map<String, String>> products, {
    double cardWidth = 150,
    double imageHeight = 90,
  }) {
    return SizedBox(
      height: cardWidth + 70,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          final product = products[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductScreen(product: product),
                ),
              );
            },
            child: Container(
              width: cardWidth,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Gambar Produk
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      height: imageHeight,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          product['image']!,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  // Info Produk
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      product['name']!,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 4.0, 10.0, 10.0),
                    child: Text(
                      product['price']!,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff8D2B2B),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Widget untuk Bottom Navigation Bar
  Widget _buildBottomNavBar() {
    return Container(
      height: 60,
      decoration: const BoxDecoration(color: Color(0xff8D2B2B)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.home, color: Colors.yellow, size: 30),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.star_border, color: Colors.white, size: 30),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: Colors.white,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.person_outline,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
