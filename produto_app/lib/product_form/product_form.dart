import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class ProductFormDialog extends StatefulWidget {
  final Map? product;

  ProductFormDialog({this.product});

  @override
  _ProductFormDialogState createState() => _ProductFormDialogState();
}

class _ProductFormDialogState extends State<ProductFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _descricaoController;
  late TextEditingController _precoController;
  late TextEditingController _estoqueController;
  late TextEditingController _dataController;

  @override
  void initState() {
  super.initState();
  _descricaoController = TextEditingController(text: widget.product?['descricao'] ?? '');
  _precoController = TextEditingController(text: widget.product?['preco']?.toString() ?? '');
  _estoqueController = TextEditingController(text: widget.product?['estoque']?.toString() ?? '');

  String formattedDate = widget.product?['data'] != null
      ? DateFormat('yyyy-MM-dd').format(DateTime.parse(widget.product!['data']))
      : '';
  _dataController = TextEditingController(text: formattedDate);
}

  Future<void> submitForm() async {
    if (_formKey.currentState!.validate()) {
      final String descricao = _descricaoController.text;
      final double preco = double.parse(_precoController.text);
      final int estoque = int.parse(_estoqueController.text);
      final String data = _dataController.text;

      if (widget.product == null) {
        final response = await http.post(
          Uri.parse('http://localhost:8080/produto'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'descricao': descricao,
            'preco': preco,
            'estoque': estoque,
            'data': data,
          }),
        );
        if (response.statusCode != 201) {
          throw Exception('Failed to create product');
        }
      } else {
        
        final response = await http.put(
          Uri.parse('http://localhost:8080/produto/${widget.product!['id']}'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'descricao': descricao,
            'preco': preco,
            'estoque': estoque,
            'data': data,
          }),
        );
        if (response.statusCode != 200) {
          throw Exception('Failed to update product');
        }
      }

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.product == null ? 'Novo Produto' : 'Editar Produto'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _descricaoController,
              decoration: InputDecoration(labelText: 'Descrição'),
              validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
            ),
            TextFormField(
              controller: _precoController,
              decoration: InputDecoration(labelText: 'Preço'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
            ),
            TextFormField(
              controller: _estoqueController,
              decoration: InputDecoration(labelText: 'Estoque'),
              keyboardType: TextInputType.number,
              validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
            ),
            TextFormField(
              controller: _dataController,
              decoration: InputDecoration(labelText: 'Data (YYYY-MM-DD)'),
              validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancelar',
              style: TextStyle(color: Color(0xFFF44336))),
        ),
        TextButton(
          onPressed: submitForm,
          child: Text('Salvar',
              style: TextStyle(color: Color(0xFF4CAF50))),
        ),
      ],
    );
  }
}
