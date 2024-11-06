import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../product_detail/product_detail.dart';
import '../product_form/product_form.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    final response =
        await http.get(Uri.parse('http://localhost:8080/produtos'));
    if (response.statusCode == 200) {
      setState(() {
        products = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Produtos',
          style: TextStyle(
              color: Color(0xFFFF6F00)),
        ),
        backgroundColor: Color(0xFF2A2D34),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(product['descricao']),
              subtitle: Text('Preço: ${product['preco']} | Estoque: ${product['estoque']}'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => ProductDetailDialog(product: product),
                ).then((_) =>
                    fetchProducts()); // refresh products after editing or deleting
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => ProductFormDialog(),
          ).then(
              (_) => fetchProducts()); // refresh products after adding new one
        },
        backgroundColor: Color(0xFFFF6F00), // Laranja vibrante
        child: Icon(Icons.add),
      ),
    );
  }
}
