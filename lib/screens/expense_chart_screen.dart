// Импорт основных виджетов Flutter
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart'
    show
        BarChart,
        BarChartData,
        BarChartGroupData,
        BarChartRodData,
        FlTitlesData,
        AxisTitles,
        SideTitles;
import 'package:ai_chat_flutter/providers/expense_provider.dart';

// Создаем класс `MyText`, который наследуется от `StatelessWidget`.
// `StatelessWidget` — это виджет, который не изменяет свое состояние после создания.
class ExpenseChartScreen extends StatelessWidget {
  // Переопределяем метод `build`, который обязателен для всех виджетов.
  // Этот метод описывает, как виджет должен отображаться на экране.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Расходы по дням'),
      ),
      body: Center(
        child: BarChart(
          BarChartData(
            maxY: 100,
            barGroups: context
                .read<ExpenseProvider>()
                .dailyExpenses
                .map((expense) => BarChartGroupData(
                      x: expense.day,
                      barRods: [
                        BarChartRodData(
                          toY: expense.amount,
                          width: 20,
                          color: Colors.blue,
                        ),
                      ],
                    ))
                .toList(),
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 1,
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 10,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
