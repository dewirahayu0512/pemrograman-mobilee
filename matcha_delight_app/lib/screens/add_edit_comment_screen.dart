import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/comment.dart';
import '../providers/comment_provider.dart';

class AddEditCommentScreen extends StatefulWidget {
  final String productId;
  final Comment? comment;

  const AddEditCommentScreen({
    super.key,
    required this.productId,
    this.comment,
  });

  @override
  State<AddEditCommentScreen> createState() => _AddEditCommentScreenState();
}

class _AddEditCommentScreenState extends State<AddEditCommentScreen> {
  final _nameCtrl = TextEditingController();
  final _msgCtrl = TextEditingController();
  int _rating = 5;

  @override
  void initState() {
    super.initState();
    if (widget.comment != null) {
      _nameCtrl.text = widget.comment!.name;
      _msgCtrl.text = widget.comment!.message;
      _rating = widget.comment!.rating;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cp = Provider.of<CommentProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.comment == null ? 'Tambah Komentar' : 'Edit Komentar',
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // 👤 NAMA
                const Text(
                  'Nama',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                TextField(
                  controller: _nameCtrl,
                  decoration: InputDecoration(
                    hintText: 'Masukkan nama',
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // 💬 KOMENTAR
                const Text(
                  'Komentar',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                TextField(
                  controller: _msgCtrl,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Tulis komentar',
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // ⭐ RATING
                const Text(
                  'Rating',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (i) {
                    return IconButton(
                      onPressed: () {
                        setState(() {
                          _rating = i + 1;
                        });
                      },
                      icon: Icon(
                        i < _rating ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                        size: 30,
                      ),
                    );
                  }),
                ),

                const SizedBox(height: 24),

                // 💾 SIMPAN
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 36, 186, 81),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      if (_nameCtrl.text.isEmpty ||
                          _msgCtrl.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Nama dan komentar wajib diisi'),
                          ),
                        );
                        return;
                      }

                      final c = Comment(
                        id: widget.comment?.id ??
                            DateTime.now().toString(),
                        productId: widget.productId,
                        name: _nameCtrl.text,
                        message: _msgCtrl.text,
                        rating: _rating,
                      );

                      widget.comment == null
                          ? cp.add(c)
                          : cp.update(c.id, c);

                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Simpan Komentar',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
