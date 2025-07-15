import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/expense.dart';

class AIService {
  static const String _baseUrl = 'https://openrouter.ai/api/v1/chat/completions';
  static const String _model = 'openai/gpt-4o';

  static Future<String> analyzeExpenses(List<Expense> expenses) async {
    try {
      final apiKey = dotenv.env['OPENROUTER_API_KEY'];
      if (apiKey == null || apiKey.isEmpty) {
        throw Exception('API key não configurada. Configure OPENROUTER_API_KEY no arquivo .env');
      }

      // Prepare expense data for analysis
      final expenseData = _prepareExpenseData(expenses);
      
      final systemPrompt = '''
Você é um assistente financeiro especializado em análise de gastos pessoais. 
Analise os dados de gastos fornecidos e forneça insights úteis em português brasileiro.

Sua análise deve incluir:
1. Resumo dos gastos totais
2. Análise por categoria (quais categorias gastam mais)
3. Padrões de gastos (dias da semana, frequência)
4. Sugestões de economia e otimização
5. Alertas sobre gastos excessivos em alguma categoria
6. Recomendações personalizadas

Seja prático, objetivo e forneça dicas acionáveis para melhorar o controle financeiro.
''';

      final userPrompt = '''
Analise os seguintes dados de gastos:

$expenseData

Forneça uma análise completa e sugestões de melhoria para o controle financeiro.
''';

      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'model': _model,
          'messages': [
            {
              'role': 'system',
              'content': [
                {'type': 'text', 'text': systemPrompt}
              ]
            },
            {
              'role': 'user',
              'content': [
                {'type': 'text', 'text': userPrompt}
              ]
            }
          ],
          'max_tokens': 1500,
          'temperature': 0.7,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final analysis = data['choices'][0]['message']['content'];
        return analysis;
      } else {
        throw Exception('Erro na análise: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Erro ao analisar gastos: $e');
    }
  }

  static String _prepareExpenseData(List<Expense> expenses) {
    if (expenses.isEmpty) {
      return 'Nenhum gasto registrado ainda.';
    }

    final buffer = StringBuffer();
    buffer.writeln('=== DADOS DOS GASTOS ===\n');

    // Total expenses
    final total = expenses.fold(0.0, (sum, expense) => sum + expense.amount);
    buffer.writeln('Total gasto: R\$ ${total.toStringAsFixed(2)}\n');

    // Expenses by category
    final Map<String, double> categoryTotals = {};
    final Map<String, int> categoryCount = {};
    
    for (final expense in expenses) {
      categoryTotals[expense.category] = 
          (categoryTotals[expense.category] ?? 0) + expense.amount;
      categoryCount[expense.category] = 
          (categoryCount[expense.category] ?? 0) + 1;
    }

    buffer.writeln('=== GASTOS POR CATEGORIA ===');
    categoryTotals.entries.forEach((entry) {
      final percentage = (entry.value / total * 100);
      buffer.writeln('${entry.key}: R\$ ${entry.value.toStringAsFixed(2)} (${percentage.toStringAsFixed(1)}%) - ${categoryCount[entry.key]} transações');
    });

    buffer.writeln('\n=== ÚLTIMOS GASTOS ===');
    final recentExpenses = expenses.take(10).toList();
    for (final expense in recentExpenses) {
      buffer.writeln('${expense.date.day}/${expense.date.month}: ${expense.title} - R\$ ${expense.amount.toStringAsFixed(2)} (${expense.category})');
    }

    return buffer.toString();
  }
}
