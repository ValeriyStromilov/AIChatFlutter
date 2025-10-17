import 'package:flutter/material.dart';

class ExpenseProvider extends ChangeNotifier {
  // Dummy data for testing
  List<DailyExpense> dailyExpenses = [
    DailyExpense(day: 0, amount: 40),
    DailyExpense(day: 1, amount: 55),
    DailyExpense(day: 2, amount: 35),
  ];
}

class DailyExpense {
  final int day;
  final double amount;
  DailyExpense({required this.day, required this.amount});
}
