enum CardType {
  products, clients, providers;
}

extension CardTypeExtension on CardType {
  String get description {
    switch (this) {
      case CardType.clients:
        return 'Clientes';
      case CardType.products:
        return 'Produtos';
      case CardType.providers:
        return 'Fornecedores';
      default:
        return "";
    }
  }
}