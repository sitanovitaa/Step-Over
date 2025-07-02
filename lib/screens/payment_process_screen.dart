import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class PaymentProcessScreen extends StatefulWidget {
  final double subtotal;

  final List<Map<String, String>> cartItems;

  const PaymentProcessScreen({
    super.key,
    required this.subtotal,
    required this.cartItems,
  });

  @override
  State<PaymentProcessScreen> createState() => _PaymentProcessScreenState();
}

class _PaymentProcessScreenState extends State<PaymentProcessScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  String _selectedDelivery = 'Standard Delivery';
  String _selectedPayment = 'Transfer Bank';

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.animateToPage(
        _currentPage + 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/order_success',
        (route) => false,
        arguments: widget.cartItems,
      );
    }
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
          _currentPage == 0
              ? 'Shopping Delivery'
              : (_currentPage == 1 ? 'Shopping Delivery' : 'Payment Method'),
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildStepper(),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(), // Disable swipe
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: [
                _buildDeliveryStep(),
                _buildAddressStep(),
                _buildPaymentStep(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomButton(),
    );
  }

  Widget _buildStepper() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildStepCircle('1', 'Delivery', _currentPage >= 0),
          _buildStepLine(),
          _buildStepCircle('2', 'Address', _currentPage >= 1),
          _buildStepLine(),
          _buildStepCircle('3', 'Payment', _currentPage >= 2),
        ],
      ),
    );
  }

  Widget _buildStepCircle(String number, String label, bool isActive) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isActive ? Colors.yellow[700] : Colors.grey[300],
            shape: BoxShape.circle,
          ),
          child: Center(
            child:
                isActive
                    ? const Icon(Icons.check, color: Colors.black)
                    : Text(
                      number,
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                    ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: isActive ? Colors.black : Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildStepLine() {
    return Expanded(
      child: Container(
        height: 2,
        color: Colors.grey[300],
        margin: const EdgeInsets.only(bottom: 28),
      ),
    );
  }

  Widget _buildDeliveryStep() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Choose your delivery",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          _buildDeliveryOption(
            "Standard Delivery",
            "2-3 Days in your hand",
            "Rp.9.000",
          ),
          _buildDeliveryOption(
            "Express Delivery",
            "1-2 Days in your hand",
            "Rp.18.000",
          ),
          _buildDeliveryOption(
            "Priority Delivery",
            "24 Hours in your hand",
            "Rp.25.000",
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryOption(String title, String subtitle, String price) {
    bool isSelected = _selectedDelivery == title;
    return GestureDetector(
      onTap: () => setState(() => _selectedDelivery = title),
      child: Card(
        color: isSelected ? Colors.red[50] : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: isSelected ? Colors.red[800]! : Colors.grey[300]!,
          ),
        ),
        elevation: 0,
        margin: const EdgeInsets.only(bottom: 16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(color: Colors.grey[600]),
                  ),
                ],
              ),
              Text(
                price,
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddressStep() {
    return ListView(
      padding: const EdgeInsets.all(24.0),
      children: [
        Text(
          "Complete your Address",
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        _buildAddressTextField("Your Name...."),
        _buildAddressTextField("Your Mail...."),
        _buildAddressTextField("Your Phone...."),
        _buildAddressTextField("Your Location...."),
        _buildAddressTextField("Zip Code...."),
        _buildAddressTextField("Your Country...."),
        _buildAddressTextField("Your City...."),
        Row(
          children: [
            Checkbox(value: true, onChanged: (val) {}),
            Text("Save your address", style: GoogleFonts.poppins()),
          ],
        ),
      ],
    );
  }

  Widget _buildAddressTextField(String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentStep() {
    final currencyFormatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp.',
      decimalDigits: 0,
    );
    String formattedSubtotal = currencyFormatter.format(widget.subtotal);

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Text(
              formattedSubtotal,
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "Choose your payment",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          _buildPaymentOption("Transfer Bank"),
          _buildPaymentOption("Virtual Account"),
          _buildPaymentOption("E-Money"),
          _buildPaymentOption("Cash On Delivery"),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(String method) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[300]!),
      ),
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        title: Text(method, style: GoogleFonts.poppins()),
        trailing: Radio<String>(
          value: method,
          groupValue: _selectedPayment,
          onChanged: (val) => setState(() => _selectedPayment = val!),
          activeColor: Colors.red[800],
        ),
        onTap: () => setState(() => _selectedPayment = method),
      ),
    );
  }

  Widget _buildBottomButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: const Color(0xff8D2B2B),
      child: ElevatedButton(
        onPressed: _nextPage,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.yellow[700],
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Text(
          _currentPage == 2 ? "Pay Now" : "Next",
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
