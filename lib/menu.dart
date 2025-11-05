import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final String nama = "Auriel Erich Ibrahim Nst";
  final String npm = "2406428806";
  final String kelas = "F";

  // Helper untuk menampilkan Snackbar agar tidak duplikat
  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
  }

  // Helper untuk membangun tombol menu (ikon + teks + warna + snackbar)
  Widget _buildMenuButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required Color color,
    required String snackMessage,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: Icon(icon),
        label: Text(label),
        onPressed: () {
          _showSnackBar(context, snackMessage);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: color,        // warna tombol
          foregroundColor: Colors.white, // warna teks & ikon
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          textStyle: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Richshop'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ====== Header & identitas ======
            Text(
              'Selamat datang di Richshop!',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16.0),
            Text('Nama  : $nama'),
            Text('NPM   : $npm'),
            Text('Kelas : $kelas'),

            const SizedBox(height: 24.0),

            // ====== Judul menu tombol ======
            Text(
              'Menu Produk Richshop',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12.0),

            // ====== Tombol 1: All Products (biru) ======
            _buildMenuButton(
              context: context,
              icon: Icons.list_alt,
              label: 'All Products',
              color: Colors.blue, // biru
              snackMessage: 'Kamu telah menekan tombol All Products',
            ),
            const SizedBox(height: 12.0),

            // ====== Tombol 2: My Products (hijau) ======
            _buildMenuButton(
              context: context,
              icon: Icons.shopping_bag,
              label: 'My Products',
              color: Colors.green, // hijau
              snackMessage: 'Kamu telah menekan tombol My Products',
            ),
            const SizedBox(height: 12.0),

            // ====== Tombol 3: Create Product (merah) ======
            _buildMenuButton(
              context: context,
              icon: Icons.add_circle_outline,
              label: 'Create Product',
              color: Colors.red, // merah
              snackMessage: 'Kamu telah menekan tombol Create Product',
            ),
          ],
        ),
      ),
    );
  }
}
