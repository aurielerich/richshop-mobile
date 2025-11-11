import 'package:flutter/material.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _thumbnailController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  bool _isFeatured = false;

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _thumbnailController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  void _showSnackBar(String message) {
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

  void _showProductDialog() {
    final String name = _nameController.text.trim();
    final String priceText = _priceController.text.trim();
    final double? price = double.tryParse(priceText);
    final String description = _descriptionController.text.trim();
    final String thumbnail = _thumbnailController.text.trim();
    final String category = _categoryController.text.trim();
    final String featuredText = _isFeatured ? 'Ya' : 'Tidak';

    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Data Produk Baru'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDialogRow('Name', name),
                _buildDialogRow('Price', (price ?? priceText).toString()),
                _buildDialogRow('Category', category),
                const SizedBox(height: 8),
                const Text(
                  'Description:',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(description),
                const SizedBox(height: 8),
                const Text(
                  'Thumbnail URL:',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(thumbnail),
                const SizedBox(height: 8),
                _buildDialogRow('Featured', featuredText),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDialogRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildSpacer() => const SizedBox(height: 16);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Produk Baru'),
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
                // Tutup drawer, lalu kembali ke route pertama (home).
                Navigator.pop(context);
                Navigator.popUntil(context, (route) => route.isFirst);
              },
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Tambah Produk'),
              onTap: () {
                // Sudah berada di halaman Tambah Produk → cukup tutup drawer.
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      // ==================================================

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ====== Judul & deskripsi singkat ======
                        Text(
                          'Form Tambah Produk Richshop',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Isi semua data produk dengan lengkap dan benar. '
                          'Field wajib tidak boleh dikosongkan dan harus sesuai tipe datanya.',
                        ),
                        const SizedBox(height: 20),

                        // ========= SECTION: Informasi Produk =========
                        _buildSectionTitle('Informasi Produk'),
                        _buildSpacer(),
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'Name',
                            hintText: 'Contoh: Jersey Timnas Indonesia 2024',
                          ),
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Name tidak boleh kosong';
                            }
                            if (value.trim().length < 3) {
                              return 'Name minimal 3 karakter';
                            }
                            if (value.trim().length > 50) {
                              return 'Name maksimal 50 karakter';
                            }
                            return null;
                          },
                        ),
                        _buildSpacer(),
                        TextFormField(
                          controller: _priceController,
                          decoration: const InputDecoration(
                            labelText: 'Price',
                            hintText: 'Masukkan harga produk, misal: 150000',
                            prefixText: 'Rp ',
                          ),
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Price tidak boleh kosong';
                            }
                            final parsed = double.tryParse(value.trim());
                            if (parsed == null) {
                              return 'Price harus berupa angka';
                            }
                            if (parsed <= 0) {
                              return 'Price harus lebih besar dari 0';
                            }
                            if (parsed > 1000000000) {
                              return 'Price terlalu besar';
                            }
                            return null;
                          },
                        ),
                        _buildSpacer(),
                        TextFormField(
                          controller: _descriptionController,
                          decoration: const InputDecoration(
                            labelText: 'Description',
                            hintText:
                                'Deskripsikan produk (bahan, ukuran, warna, dsb.)',
                          ),
                          maxLines: 3,
                          textInputAction: TextInputAction.newline,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Description tidak boleh kosong';
                            }
                            if (value.trim().length < 10) {
                              return 'Description minimal 10 karakter';
                            }
                            if (value.trim().length > 300) {
                              return 'Description maksimal 300 karakter';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 24),
                        const Divider(),
                        const SizedBox(height: 16),

                        // ========= SECTION: Media & Kategori =========
                        _buildSectionTitle('Media & Kategori'),
                        _buildSpacer(),
                        TextFormField(
                          controller: _thumbnailController,
                          decoration: const InputDecoration(
                            labelText: 'Thumbnail URL',
                            hintText:
                                'Masukkan URL gambar produk (http(s)://...)',
                          ),
                          keyboardType: TextInputType.url,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Thumbnail URL tidak boleh kosong';
                            }
                            final url = value.trim();
                            final uri = Uri.tryParse(url);
                            final isValidUrl = uri != null &&
                                uri.hasScheme &&
                                (uri.scheme == 'http' ||
                                    uri.scheme == 'https') &&
                                uri.host.isNotEmpty;
                            if (!isValidUrl) {
                              return 'Masukkan URL yang valid (diawali http atau https)';
                            }
                            if (url.length > 200) {
                              return 'URL terlalu panjang (maksimal 200 karakter)';
                            }
                            return null;
                          },
                        ),
                        _buildSpacer(),
                        TextFormField(
                          controller: _categoryController,
                          decoration: const InputDecoration(
                            labelText: 'Category',
                            hintText:
                                'Contoh: Jersey, Sepatu, Bola, Aksesoris',
                          ),
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Category tidak boleh kosong';
                            }
                            if (value.trim().length < 3) {
                              return 'Category minimal 3 karakter';
                            }
                            if (value.trim().length > 30) {
                              return 'Category maksimal 30 karakter';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 24),
                        const Divider(),
                        const SizedBox(height: 16),

                        // ========= SECTION: Pengaturan Tambahan =========
                        _buildSectionTitle('Pengaturan Tambahan'),
                        const SizedBox(height: 8),
                        SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text('Featured product'),
                          subtitle: const Text(
                            'Aktifkan jika produk ini ingin ditampilkan sebagai produk unggulan.',
                          ),
                          value: _isFeatured,
                          onChanged: (bool value) {
                            setState(() {
                              _isFeatured = value;
                            });
                          },
                        ),

                        const SizedBox(height: 24),

                        // ========= Tombol Reset & Save =========
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  _formKey.currentState?.reset();
                                  _nameController.clear();
                                  _priceController.clear();
                                  _descriptionController.clear();
                                  _thumbnailController.clear();
                                  _categoryController.clear();
                                  setState(() {
                                    _isFeatured = false;
                                  });
                                },
                                child: const Text('Reset'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  final isValid =
                                      _formKey.currentState?.validate() ??
                                          false;

                                  if (!isValid) {
                                    _showSnackBar(
                                      'Masih ada input yang tidak valid. Periksa pesan error berwarna merah.',
                                    );
                                    return;
                                  }

                                  _showProductDialog();
                                },
                                child: const Text('Save'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
