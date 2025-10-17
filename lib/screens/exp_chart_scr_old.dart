// Импорт основных виджетов Flutter
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'
    show
        BarChart,
        BarChartData,
        BarChartGroupData,
        BarChartRodData,
        FlTitlesData,
        AxisTitles,
        SideTitles;

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
            barGroups: [
              BarChartGroupData(
                x: 0,
                barRods: [
                  BarChartRodData(
                    toY: 40,
                    width: 20,
                    color: Colors.blue,
                  ),
                ],
                showingTooltipIndicators: [0],
              ),
              BarChartGroupData(
                x: 1,
                barRods: [
                  BarChartRodData(
                    toY: 55,
                    width: 20,
                    color: Colors.blue,
                  ),
                ],
                showingTooltipIndicators: [0],
              ),
              BarChartGroupData(
                x: 2,
                barRods: [
                  BarChartRodData(
                    toY: 35,
                    width: 20,
                    color: Colors.blue,
                  ),
                ],
                showingTooltipIndicators: [0],
              ),
            ],
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
