import 'package:flutter/material.dart';
import '../components/dashboard_card.dart';
import '../components/main_drawer.dart';
import '../services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<dynamic>> _dashboardData;

  @override
  void initState() {
    super.initState();
    _dashboardData = _loadDashboardData();
  }

  Future<List<dynamic>> _loadDashboardData() async {
    final cars = await _apiService.getCars();
    final categories = await _apiService.getCategories();

    final totalValue =
        cars.fold(0.0, (sum, car) => sum + (car.price * car.quantity));
    final lowStock = cars.where((car) => car.quantity <= 5).length;

    return [
      cars.length,
      totalValue,
      categories.length,
      lowStock,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      drawer: const MainDrawer(),
      body: FutureBuilder<List<dynamic>>(
        future: _dashboardData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }

          final data = snapshot.data!;

          return GridView.count(
            crossAxisCount: 2,
            padding: const EdgeInsets.all(16),
            children: [
              DashboardCard(
                title: 'Total de Carros',
                value: '${data[0]}',
                icon: Icons.directions_car,
              ),
              DashboardCard(
                title: 'Valor em Estoque',
                value: 'R\$ ${data[1].toStringAsFixed(2)}',
                icon: Icons.attach_money,
                color: Colors.green,
              ),
              DashboardCard(
                title: 'Categorias',
                value: '${data[2]}',
                icon: Icons.category,
                color: Colors.orange,
              ),
              DashboardCard(
                title: 'Baixo Estoque',
                value: '${data[3]}',
                icon: Icons.warning,
                color: Colors.red,
              ),
            ],
          );
        },
      ),
    );
  }
}
