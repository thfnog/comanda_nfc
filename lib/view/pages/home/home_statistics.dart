import 'package:comanda_nfc/model/metodo_pagamento_data.dart';
import 'package:comanda_nfc/model/product_data.dart';
import 'package:flutter/material.dart';

import '../../../const/color_constants.dart';
import '../../../const/text_constants.dart';

class HomeStatistics extends StatelessWidget {
  const HomeStatistics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _createCardsList(context),
    );
  }

  Widget _createCardsList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 230,
          width: double.infinity,
          child: ListView(
            padding: EdgeInsets.all(5),
            scrollDirection: Axis.horizontal,
            children: [
              _createSalesMade(
                  context,
                  SalesMadeData(
                      title: TextConstants.sales,
                      quantity: 56,
                      description: TextConstants.totalSalesMade,
                      icon: Icons.insights)),
              _createColumnStatistics(),
              _createSalesMade(
                  context,
                  SalesMadeData(
                      title: TextConstants.invoicing,
                      quantity: 2000,
                      description: TextConstants.totalInvoicing,
                      icon: Icons.attach_money_sharp)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _createSalesMade(BuildContext context, SalesMadeData salesMadeData) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.all(15),
      height: 200,
      width: screenWidth * 0.45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorConstants.white,
        boxShadow: [
          BoxShadow(
            color: ColorConstants.textBlack.withOpacity(0.12),
            blurRadius: 5.0,
            spreadRadius: 1.1,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Icon(salesMadeData.icon),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  salesMadeData.title,
                  style: TextStyle(
                    color: ColorConstants.textBlack,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.fade,
                  softWrap: false,
                ),
              ),
            ],
          ),
          Text(
            salesMadeData.quantity.toString(),
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w700,
              color: ColorConstants.textBlack,
            ),
          ),
          Text(
            salesMadeData.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: ColorConstants.textGrey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _createColumnStatistics() {
    List<ProductData> products = buildTempProductsData();
    List<PaymentMethodData> paymentsMethod = buildTempPaymentsMethodData();
    return Container(
      padding: EdgeInsets.all(10),
      child: Wrap(
        direction: Axis.vertical,
        alignment: WrapAlignment.spaceBetween,
        children: [
          for (var product in products)
            DataInvoicing(
              icon: Icons.fastfood_sharp,
              title: product.name,
              count: product.quantity,
              text: "em estoque",
            ),
          DataInvoicing(
            icon: Icons.add_card_sharp,
            title: "Comandas ativas",
            count: 62,
            text: "",
          ),
          DataInvoicing(
            icon: Icons.credit_card_off,
            title: "Comandas pagas",
            count: 10,
            text: "",
          ),
          DataInvoicing(
            icon: Icons.people,
            title: "Total de clientes",
            count: 72,
            text: "pessoas",
          ),
          for (var paymentMethod in paymentsMethod)
            DataInvoicing(
              icon: Icons.payments_sharp,
              title: "Pags c/ " + paymentMethod.name,
              count: paymentMethod.quantity,
              text: "",
            ),
        ],
      ),
    );
  }

  List<ProductData> buildTempProductsData() {
    ProductData product1 = new ProductData(null, name: "Cerveja", quantity: 2, value: 15, description: "Cerveja X");
    ProductData product2 = new ProductData(null, name: "Bolo", quantity: 10, value: 6, description: "Bolo X");
    ProductData product3 = new ProductData(null, name: "Espeto de carne", quantity: 20, value: 7, description: "Espeto X");
    final products = <ProductData>[product1, product2, product3];
    return products;
  }

  List<PaymentMethodData> buildTempPaymentsMethodData() {
    PaymentMethodData paymentMethodData1 =
        new PaymentMethodData(name: "Cartão", quantity: 20);
    PaymentMethodData paymentMethodData2 =
        new PaymentMethodData(name: "Dinheiro", quantity: 8);
    PaymentMethodData paymentMethodData3 =
        new PaymentMethodData(name: "Pix", quantity: 2);
    final paymentsMethod = <PaymentMethodData>[
      paymentMethodData1,
      paymentMethodData2,
      paymentMethodData3
    ];
    return paymentsMethod;
  }
}

class SalesMadeData {
  final String title;
  final int quantity;
  final String description;
  final IconData icon;

  SalesMadeData(
      {required this.title,
      required this.quantity,
      required this.description,
      required this.icon});
}

class DataInvoicing extends StatelessWidget {
  final IconData icon;
  final String title;
  final int count;
  final String text;

  DataInvoicing({
    required this.icon,
    required this.title,
    required this.count,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.all(5),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: 90,
      width: screenWidth * 0.6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorConstants.white,
        boxShadow: [
          BoxShadow(
            color: ColorConstants.textBlack.withOpacity(0.12),
            blurRadius: 5.0,
            spreadRadius: 1.1,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Icon(icon),
              const SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: ColorConstants.textBlack,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                count.toString(),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: ColorConstants.textBlack,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: ColorConstants.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
