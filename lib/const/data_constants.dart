import 'package:comanda_nfc/model/product_data.dart';
import 'package:comanda_nfc/model/provider_data.dart';

import '../model/invoice_data.dart';
import '../model/person_data.dart';
import '../model/register.dart';

class DataConstants {
  // Provider
  static final List<Register> providers = [
    ProviderData(
        providerName: "Zezinho do bar",
        cnpj: "96.503.340/0001-04",
        phoneNumber: "(11) 95515-4854",
        responsible: "Fulano 1"),
    ProviderData(
        providerName: "Bla1",
        cnpj: "78.109.049/0001-74",
        phoneNumber: "(11) 97125-8327",
        responsible: "Zezinho"),
    ProviderData(
        providerName: "bla2",
        cnpj: "66.466.122/0001-86",
        phoneNumber: "(11) 92242-4374",
        responsible: "Alfredo"),
    ProviderData(
        providerName: "bla3",
        cnpj: "93.695.310/0001-59",
        phoneNumber: "(11) 98305-9045",
        responsible: "Juninho"),
  ];

  // Clients
  static final List<Register> clients = [
    PersonData(
        name: "Fulano de Tal 1",
        cpf: "645.845.830-48",
        cardId: "123",
        phoneNumber: "(11) 99666-6007"),
    PersonData(
        name: "Fulano de Tal 2",
        cpf: "486.422.630-08",
        cardId: "124",
        phoneNumber: "(11) 95882-5287"),
    PersonData(
        name: "Fulano de Tal 3",
        cpf: "461.011.430-58",
        cardId: "125",
        phoneNumber: "(11) 99442-5881"),
    PersonData(
        name: "Fulano de Tal 4",
        cpf: "377.415.880-01",
        cardId: "126",
        phoneNumber: "(11) 94816-7436"),
    PersonData(
        name: "Fulano de Tal 5",
        cpf: "551.588.650-00",
        cardId: "127",
        phoneNumber: "(11) 94468-4511"),
  ];

  // Products for register
  static final List<Register> productsRegister = [
    ProductData(
        description: 'Bolo diversos', name: "Bolo", quantity: 32, value: 6),
    ProductData(
        description: 'Chopp Brahma 500ml',
        name: "Chopp",
        quantity: 78,
        value: 14),
    ProductData(
        description: 'Diversos', name: "Lanche", quantity: 59, value: 32),
    ProductData(
        description: 'Diversos', name: "Chocolate", quantity: 22, value: 4),
    ProductData(
        description: 'Água sem gás 500ml', name: "Agua", quantity: 1, value: 4),
  ];

  static final List<ProductData> products = [
    ProductData(
        description: 'Bolo diversos', name: "Bolo", quantity: 32, value: 6),
    ProductData(
        description: 'Chopp Brahma 500ml',
        name: "Chopp",
        quantity: 78,
        value: 14),
    ProductData(
        description: 'Diversos', name: "Lanche", quantity: 59, value: 32),
    ProductData(
        description: 'Diversos', name: "Chocolate", quantity: 22, value: 4),
    ProductData(
        description: 'Água sem gás 500ml', name: "Agua", quantity: 1, value: 4),
  ];

  static final InvoiceData invoiceData = InvoiceData(
      personData: PersonData(
          name: "Fulano de Tal",
          cpf: '227.996.348.50',
          cardId: '23',
          products: DataConstants.products),
      datetime: DateTime.now(),
      totalAmount: DataConstants.products
          .map((e) => e.value * e.quantity)
          .reduce((value, element) => value + element));
}
