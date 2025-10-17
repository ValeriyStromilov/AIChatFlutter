import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Настройки API'),
        backgroundColor: Colors.blueGrey[800],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Выберите провайдера:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              value: context.watch<SettingsProvider>().selectedProvider,
              items: [
                DropdownMenuItem(
                  value: 'openrouter',
                  child: Text('OpenRouter',
                      style: TextStyle(color: Colors.blue[300])),
                ),
                DropdownMenuItem(
                  value: 'vsegpt',
                  child: Text('VSEGPT',
                      style: TextStyle(color: Colors.orange[400])),
                ),
              ],
              onChanged: (value) {
                context.read<SettingsProvider>().updateProvider(value!);
              },
              underline: Container(
                //Настраиваем границу снизу
                height: 1,
                color: Colors.blueGrey[800]?.withValues(alpha: 0.5),
              ),
              icon: Icon(
                  Icons.keyboard_arrow_down), // Опционально добавляем стрелочку
              focusColor: Colors.blue, // Цвет подсветки при фокусировке
              dropdownColor: Colors.white, // Фон выпадающего списка
              iconDisabledColor:
                  Colors.grey[200], // Цвет иконки при отключенном состоянии
              iconEnabledColor:
                  Colors.blue, // Цвет иконки при активном состоянии
            ),
            SizedBox(height: 20),
            Text(
              'API Key:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: context.read<SettingsProvider>().apiKeyController,
              decoration: InputDecoration(
                hintText: 'Введите ваш ключ API',
                border: OutlineInputBorder(),
                errorText: context.watch<SettingsProvider>().apiKeyError,
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    context.read<SettingsProvider>().clearApiKey();
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.read<SettingsProvider>().saveSettings();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Настройки успешно сохранены!'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: Text('Сохранить настройки'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[700],
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsProvider extends ChangeNotifier {
  String selectedProvider = 'openrouter';
  TextEditingController apiKeyController = TextEditingController();
  String apiKeyError = '';

  void updateProvider(String provider) {
    selectedProvider = provider;
    notifyListeners();
  }

  void clearApiKey() {
    apiKeyController.clear();
    notifyListeners();
  }

  void saveSettings() {
    if (apiKeyController.text.isEmpty) {
      apiKeyError = 'Введите API ключ';
    } else if (!apiKeyController.text.startsWith('sk-or')) {
      apiKeyError =
          'Неверный формат API ключа. Ключ должен начинаться с "sk-or"';
    } else {
      apiKeyError = '';
      // Here you would typically save to persistent storage
      _saveToStorage();
    }
    notifyListeners();
  }

  void _saveToStorage() {
    // Implementation for persisting settings
    print(
        'Сохранение настроек: провайдер=$selectedProvider, ключ=${apiKeyController.text}');
    // Add your preferred storage solution here (shared_preferences, Hive, etc.)
  }
}
