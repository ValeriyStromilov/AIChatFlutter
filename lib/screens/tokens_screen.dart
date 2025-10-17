import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/chat_provider.dart';

class TokensScreen extends StatefulWidget {
  const TokensScreen({super.key});

  @override
  State<TokensScreen> createState() => _TokensScreenState();
}

class _TokensScreenState extends State<TokensScreen> {
  Map<String, dynamic>? usageData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUsageData();
  }

  Future<void> _loadUsageData() async {
    try {
      // TODO: Replace this with your actual data fetching implementation
      // Example: var data = await YourApiService.getTokenUsage();
      // For now, we'll simulate data loading
      await Future.delayed(Duration(seconds: 1)); // Simulate network delay

      // This is mock data - replace with your real data source
      var mockData = {
        'total': '1,250',
        'today': '150',
        'month': '850',
        'history': [
          {'day': 'Вчера', 'usage': '120'},
          {'day': '2 дня назад', 'usage': '95'},
          {'day': '3 дня назад', 'usage': '110'},
        ]
      };

      setState(() {
        usageData = mockData;
        isLoading = false;
      });
    } catch (e) {
      // Handle errors - show error message or retry logic
      print('Error loading data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Статистика использования токенов'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatCard(
                'Всего токенов использовано', usageData?['total'] ?? '0'),
            _buildStatCard('За сегодня', usageData?['today'] ?? '0'),
            _buildStatCard('За этот месяц', usageData?['month'] ?? '0'),
            SizedBox(height: 20),
            Text('История',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ..._buildHistoryList(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loadUsageData,
              child: Text('Обновить'),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildHistoryList() {
    if (usageData?['history'] == null) return [SizedBox.shrink()];

    return (usageData?['history'] as List)
        .map((item) => _buildUsageItem(item['day'], item['usage']))
        .toList();
  }

  Widget _buildStatCard(String title, String value) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(title, style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text(value,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildUsageItem(String day, String usage) {
    return ListTile(
      title: Text(day),
      trailing: Text(usage),
    );
  }
}
