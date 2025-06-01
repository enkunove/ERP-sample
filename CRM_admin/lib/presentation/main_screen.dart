import 'package:crm_admin/presentation/news_screen.dart';
import 'package:crm_admin/presentation/qr_scanner_screen.dart';
import 'package:flutter/material.dart';

import 'logs_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Панель администратора"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _menuButton(
              context: context,
              icon: Icons.qr_code_scanner,
              label: "Сканер QR",
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => QrScanPage(),
                ));
              },
            ),
            const SizedBox(height: 20),
            _menuButton(
              context: context,
              icon: Icons.history,
              label: "Логи пользователей",
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => LogsScreen(),
                ));
              },
            ),
            const SizedBox(height: 20),
            _menuButton(
              context: context,
              icon: Icons.newspaper,
              label: "Управление новостями",
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => const NewsScreen(),
                ));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton.icon(
        icon: Icon(icon, size: 35, color: Colors.blue,),
        label: Text(label, style: const TextStyle(fontSize: 18, color: Colors.black)),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
