import 'package:flutter/material.dart';
import 'add_product_page.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final String nama = "Auriel Erich Ibrahim Nst";
  final String npm = "2406428806";
  final String kelas = "F";

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

  // Helper tombol menu (ikon + teks + warna).
  Widget _buildMenuButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required Color color,
    String? snackMessage,
    VoidCallback? onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: Icon(icon),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
        ),
        onPressed: onPressed ??
            () {
              if (snackMessage != null) {
                _showSnackBar(context, snackMessage);
              }
            },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Richshop'),
      ),

      // ===================== DRAWER =====================
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Richshop Menu',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Halaman Utama'),
              onTap: () {
                // Sudah berada di halaman utama → cukup tutup drawer.
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Tambah Produk'),
              onTap: () {
                Navigator.pop(context); // tutup drawer dulu
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AddProductPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      // ==================================================

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
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
              const SizedBox(height: 8),
              Text('Nama  : $nama'),
              Text('NPM   : $npm'),
              Text('Kelas : $kelas'),
              const SizedBox(height: 24),

              // ====== Card menu ======
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Menu Produk Richshop',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Pilih salah satu menu di bawah untuk melihat daftar produk, '
                        'produk milikmu, atau menambahkan produk baru.',
                      ),
                      const SizedBox(height: 20),

                      // All Products (biru)
                      _buildMenuButton(
                        context: context,
                        icon: Icons.list_alt,
                        label: 'All Products',
                        color: Colors.blue,
                        snackMessage:
                            'Kamu telah menekan tombol All Products',
                      ),
                      const SizedBox(height: 12),

                      // My Products (hijau)
                      _buildMenuButton(
                        context: context,
                        icon: Icons.shopping_bag,
                        label: 'My Products',
                        color: Colors.green,
                        snackMessage:
                            'Kamu telah menekan tombol My Products',
                      ),
                      const SizedBox(height: 12),

                      // Create Product (merah) → navigasi ke form
                      _buildMenuButton(
                        context: context,
                        icon: Icons.add_circle_outline,
                        label: 'Create Product',
                        color: Colors.red,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const AddProductPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
