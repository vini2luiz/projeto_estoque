// lib/screens/car_list_screen.dart
import 'package:flutter/material.dart';
import '../models/car.dart';
import '../services/api_service.dart';
import '../components/car_card.dart';
import 'car_form_screen.dart';
import '../components/main_drawer.dart';

class CarListScreen extends StatefulWidget {
  const CarListScreen({Key? key}) : super(key: key);

  @override
  State<CarListScreen> createState() => _CarListScreenState();
}

class _CarListScreenState extends State<CarListScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<Car>> _carsFuture;

  @override
  void initState() {
    super.initState();
    _loadCars();
  }

  void _loadCars() {
    _carsFuture = _apiService.getCars();
  }

  Future<void> _deleteCar(String id) async {
    try {
      await _apiService.deleteCar(id);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Carro removido com sucesso')),
      );
      setState(() {
        _loadCars();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao remover carro: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estoque de Carros'),
      ),
      drawer: const MainDrawer(),
      body: FutureBuilder<List<Car>>(
        future: _carsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
                child: Text('Erro ao carregar dados: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum carro encontrado'));
          }

          final cars = snapshot.data!;
          return ListView.builder(
            itemCount: cars.length,
            itemBuilder: (context, index) {
              final car = cars[index];
              return CarCard(
                car: car,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CarFormScreen(car: car),
                    ),
                  ).then((_) {
                    setState(() {
                      _loadCars();
                    });
                  });
                },
                onDelete: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Confirmar exclusão'),
                      content: Text(
                          'Deseja realmente excluir o carro ${car.brand} ${car.model}?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Cancelar'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            _deleteCar(car.id!);
                          },
                          child: const Text('Excluir'),
                          style:
                              TextButton.styleFrom(foregroundColor: Colors.red),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CarFormScreen()),
          ).then((_) {
            setState(() {
              _loadCars();
            });
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
