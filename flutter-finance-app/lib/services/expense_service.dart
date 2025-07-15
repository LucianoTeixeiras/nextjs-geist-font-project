import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/expense.dart';

class ExpenseService {
  static const String _expensesKey = 'expenses';

  static Future<List<Expense>> getExpenses() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final expensesJson = prefs.getStringList(_expensesKey) ?? [];
      
      return expensesJson
          .map((json) => Expense.fromJson(jsonDecode(json)))
          .toList()
        ..sort((a, b) => b.date.compareTo(a.date)); // Sort by date descending
    } catch (e) {
      print('Erro ao carregar gastos: $e');
      return [];
    }
  }

  static Future<void> addExpense(Expense expense) async {
    try {
      final expenses = await getExpenses();
      expenses.add(expense);
      await _saveExpenses(expenses);
    } catch (e) {
      throw Exception('Erro ao adicionar gasto: $e');
    }
  }

  static Future<void> updateExpense(Expense updatedExpense) async {
    try {
      final expenses = await getExpenses();
      final index = expenses.indexWhere((e) => e.id == updatedExpense.id);
      
      if (index != -1) {
        expenses[index] = updatedExpense;
        await _saveExpenses(expenses);
      } else {
        throw Exception('Gasto não encontrado');
      }
    } catch (e) {
      throw Exception('Erro ao atualizar gasto: $e');
    }
  }

  static Future<void> deleteExpense(String expenseId) async {
    try {
      final expenses = await getExpenses();
      expenses.removeWhere((e) => e.id == expenseId);
      await _saveExpenses(expenses);
    } catch (e) {
      throw Exception('Erro ao deletar gasto: $e');
    }
  }

  static Future<void> _saveExpenses(List<Expense> expenses) async {
    final prefs = await SharedPreferences.getInstance();
    final expensesJson = expenses
        .map((expense) => jsonEncode(expense.toJson()))
        .toList();
    
    await prefs.setStringList(_expensesKey, expensesJson);
  }

  static Future<double> getTotalExpenses() async {
    final expenses = await getExpenses();
    return expenses.fold(0.0, (sum, expense) => sum + expense.amount);
  }

  static Future<Map<String, double>> getExpensesByCategory() async {
    final expenses = await getExpenses();
    final Map<String, double> categoryTotals = {};
    
    for (final expense in expenses) {
      categoryTotals[expense.category] = 
          (categoryTotals[expense.category] ?? 0) + expense.amount;
    }
    
    return categoryTotals;
  }

  static Future<List<Expense>> getExpensesThisMonth() async {
    final expenses = await getExpenses();
    final now = DateTime.now();
    final thisMonth = DateTime(now.year, now.month);
    final nextMonth = DateTime(now.year, now.month + 1);
    
    return expenses.where((expense) => 
        expense.date.isAfter(thisMonth.subtract(const Duration(days: 1))) &&
        expense.date.isBefore(nextMonth)
    ).toList();
  }
}
