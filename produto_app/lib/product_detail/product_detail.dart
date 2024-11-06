import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../product_form/product_form.dart';
import 'package:intl/intl.dart';

class ProductDetailDialog extends StatelessWidget {
  final Map product;

  ProductDetailDialog({required this.product});

  Future<void> deleteProduct(BuildContext context) async {
    final response = await http
        .delete(Uri.parse('http://localhost:8080/produto/${product['id']}'));
    if (response.statusCode == 200) {
      Navigator.of(context).popUntil((route) => route.isFirst);
    } else {
      throw Exception('Failed to delete product');
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime parsedDate = DateTime.parse(product['data']);
    String formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);

    return AlertDialog(
      title: Text(product['descricao']),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Preço: ${product['preco']}'),
          Text('Estoque: ${product['estoque']}'),
          Text('Data: $formattedDate'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => ProductFormDialog(product: product),
            ).then((_) => Navigator.of(context).pop());
          },
          child: Text('Editar', style: TextStyle(color: Color(0xFF1976D2))),
        ),
        TextButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Confirmar'),
                content:
                    Text('Você tem certeza que deseja apagar este produto?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      deleteProduct(context);
                    },
                    child: Text('Excluir',
                        style: TextStyle(color: Color(0xFFF44336))),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancelar',
                        style: TextStyle(color: Color(0xFF1976D2))),
                  ),
                ],
              ),
            );
          },
          child: Text('Apagar',
              style: TextStyle(color: Color(0xFFF44336))),
        ),
      ],
    );
  }
}
