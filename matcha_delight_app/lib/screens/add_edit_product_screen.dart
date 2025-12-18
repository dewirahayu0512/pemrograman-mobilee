import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/product_provider.dart';

class AddEditProductScreen extends StatefulWidget {
  final String category;
  final Product? product;

  const AddEditProductScreen({
    super.key,
    required this.category,
    this.product,
  });

  @override
  State<AddEditProductScreen> createState() =>
      _AddEditProductScreenState();
}

class _AddEditProductScreenState extends State<AddEditProductScreen> {
  late TextEditingController nameC;
  late TextEditingController priceC;
  late TextEditingController descC;

  @override
  void initState() {
    super.initState();
    nameC = TextEditingController(text: widget.product?.name ?? '');
    priceC =
        TextEditingController(text: widget.product?.price.toString() ?? '');
    descC =
        TextEditingController(text: widget.product?.description ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<ProductProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product == null ? 'Tambah Produk' : 'Edit Produk',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameC,
              decoration: const InputDecoration(labelText: 'Nama'),
            ),
            TextField(
              controller: priceC,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Harga'),
            ),
            TextField(
              controller: descC,
              decoration: const InputDecoration(labelText: 'Deskripsi'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Simpan'),
              onPressed: () {
                final product = Product(
                  id: widget.product?.id ??
                      DateTime.now().toString(),
                  name: nameC.text,
                  category: widget.category,
                  price: int.parse(priceC.text),
                  image: 'assets/images/matcha_latte.jpg',
                  description: descC.text,
                );

                widget.product == null
                    ? provider.add(product)
                    : provider.update(product.id, product);

                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
