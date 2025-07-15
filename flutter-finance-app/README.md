# App de Controle Financeiro com IA

Um aplicativo Flutter para controle financeiro pessoal com análise inteligente de gastos usando IA.

## 🚀 Funcionalidades

- ✅ Adicionar e gerenciar gastos pessoais
- ✅ Categorização de despesas
- ✅ Visualização de resumo financeiro
- ✅ Análise inteligente de gastos usando IA (OpenRouter/GPT-4o)
- ✅ Interface moderna e limpa
- ✅ Armazenamento local dos dados
- ✅ Exclusão de gastos

## 🛠️ Tecnologias Utilizadas

- **Flutter** - Framework de desenvolvimento
- **Dart** - Linguagem de programação
- **SharedPreferences** - Armazenamento local
- **HTTP** - Requisições para API de IA
- **OpenRouter API** - Análise inteligente com GPT-4o
- **Material Design** - Interface do usuário

## 📋 Pré-requisitos

- Flutter SDK (versão 3.0.0 ou superior)
- Dart SDK
- Android Studio ou VS Code
- Chave da API do OpenRouter

## 🔧 Configuração

### 1. Clone ou baixe o projeto

### 2. Instale as dependências
```bash
cd flutter-finance-app
flutter pub get
```

### 3. Configure a API Key
Edite o arquivo `.env` e adicione sua chave da API do OpenRouter:
```
OPENROUTER_API_KEY=sua_chave_da_api_aqui
```

**Como obter a chave da API:**
1. Acesse [OpenRouter.ai](https://openrouter.ai)
2. Crie uma conta
3. Vá para a seção de API Keys
4. Gere uma nova chave
5. Cole a chave no arquivo `.env`

### 4. Execute o aplicativo
```bash
flutter run
```

## 📱 Como Usar

### Tela Principal
- Visualize o total de gastos
- Veja a lista de todas as despesas
- Acesse rapidamente as funcionalidades principais

### Adicionar Gasto
1. Toque no botão "Adicionar Gasto"
2. Preencha os campos:
   - Título do gasto
   - Valor em reais
   - Categoria
   - Data
   - Descrição (opcional)
3. Toque em "Salvar Gasto"

### Análise por IA
1. Toque no botão "Análise IA" na tela principal
2. Aguarde a análise ser processada
3. Visualize insights personalizados sobre seus gastos:
   - Resumo dos gastos totais
   - Análise por categoria
   - Padrões de gastos
   - Sugestões de economia
   - Recomendações personalizadas

### Gerenciar Gastos
- Visualize todos os gastos na tela principal
- Toque no ícone de lixeira para excluir um gasto
- Confirme a exclusão no diálogo

## 🎨 Categorias Disponíveis

- 🍽️ Alimentação
- 🚗 Transporte
- 🎬 Entretenimento
- 🏥 Saúde
- 📚 Educação
- 🛍️ Compras
- 📄 Contas
- 📦 Outros

## 🔒 Privacidade

- Todos os dados são armazenados localmente no dispositivo
- A análise por IA envia apenas dados agregados (sem informações pessoais)
- Nenhum dado financeiro é armazenado em servidores externos

## 🐛 Solução de Problemas

### Erro na Análise por IA
- Verifique se a chave da API está configurada corretamente no arquivo `.env`
- Certifique-se de ter conexão com a internet
- Verifique se sua chave da API tem créditos disponíveis

### Problemas de Instalação
```bash
# Limpar cache do Flutter
flutter clean
flutter pub get

# Verificar instalação do Flutter
flutter doctor
```

## 📄 Estrutura do Projeto

```
lib/
├── main.dart                 # Ponto de entrada da aplicação
├── models/
│   └── expense.dart         # Modelo de dados para gastos
├── services/
│   ├── ai_service.dart      # Serviço de análise por IA
│   └── expense_service.dart # Serviço de gerenciamento de gastos
└── screens/
    ├── home_screen.dart           # Tela principal
    ├── add_expense_screen.dart    # Tela de adicionar gasto
    └── ai_analysis_screen.dart    # Tela de análise por IA
```

## 🤝 Contribuição

Sinta-se à vontade para contribuir com melhorias:
1. Faça um fork do projeto
2. Crie uma branch para sua feature
3. Commit suas mudanças
4. Abra um Pull Request

## 📝 Licença

Este projeto é de código aberto e está disponível sob a licença MIT.

## 🆘 Suporte

Se encontrar problemas ou tiver dúvidas:
1. Verifique a seção de solução de problemas
2. Consulte a documentação do Flutter
3. Abra uma issue no repositório

---

**Desenvolvido com ❤️ usando Flutter**
