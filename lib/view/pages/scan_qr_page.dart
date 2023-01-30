import 'package:diyo/models/restaurant_model.dart';
import 'package:diyo/view/pages/menu_page.dart';
import 'package:flutter/material.dart';

import 'package:mobile_scanner/mobile_scanner.dart';

class ScanQRPage extends StatefulWidget {
  final RestaurantModel? restaurant;
  const ScanQRPage({super.key, this.restaurant});

  @override
  State<ScanQRPage> createState() => _ScanQRPageState();
}

class _ScanQRPageState extends State<ScanQRPage> {
  MobileScannerController cameraController = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MobileScanner(
        allowDuplicates: false,
        onDetect: (barcode, args) {
          if (barcode.rawValue == null) {
            debugPrint('Failed to scan Barcode');
          } else {
            final String code = barcode.rawValue!;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MenuPage(value: code, restaurant: widget.restaurant,),
              ),
            );
          }
        },
      ),
    );
  }
}
