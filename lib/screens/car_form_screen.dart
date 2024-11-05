import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/car.dart';
import '../services/api_service.dart';

class CarFormScreen extends StatefulWidget {
  final Car? car;

  const CarFormScreen({Key? key, this.car}) : super(key: key);

  @override
  State<CarFormScreen> createState() => _CarFormScreenState();
}

class _CarFormScreenState extends State<CarFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _apiService = ApiService();
  
  late TextEditingController _modelController;
  late TextEditingController _brandController;
  late TextEditingController _yearController;
  late TextEditingController _priceController;
  late TextEditingController _quantityController;

  @override
  void initState() {
    super.initState();
    _modelController = TextEditingController(text: widget.car?.model);
    _brandController = TextEditingController(text: widget.car?.brand);
    _yearController = TextEditingController(text: widget.car?.year.toString());
    _priceController = TextEditingController(text: widget.car?.price.toString());
    _quantityController = TextEditingController(text: widget.car?.quantity.toString());
  }

  @override
  void dispose() {
    _modelController.dispose();
    _brandController.dispose();
    _yearController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  String? _validateNotEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  String? _validateNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }
    if (int.tryParse(value) == null) {
      return 'Digite um número válido';
    }
    return null;
  }

  String? _validatePrice(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }
    if (double.tryParse(value) == null) {
      return 'Digite um valor válido';
    }