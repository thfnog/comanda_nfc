import 'package:comanda_nfc/model/product_data.dart';

class Report {

  final String provider;
  final List<ProductData> products;
  final double totalValue;

  Report({
    required this.provider,
    this.products = const <ProductData>[],
    required this.totalValue
  });

}
