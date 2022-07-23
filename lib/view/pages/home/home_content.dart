import 'package:comanda_nfc/model/product_data.dart';
import 'package:comanda_nfc/model/report.dart';
import 'package:comanda_nfc/view/pages/report_details/page/report_details_page.dart';
import 'package:flutter/material.dart';

import '../../../const/color_constants.dart';
import '../../../const/data_constants.dart';
import '../../../const/text_constants.dart';
import '../register_details/page/register_details_page.dart';
import 'home_card.dart';
import 'home_statistics.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstants.homeBackgroundColor,
      height: double.infinity,
      width: double.infinity,
      child: _createHomeBody(context),
    );
  }

  Widget _createHomeBody(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        children: [
          HomeStatistics(),
          const SizedBox(height: 10),
          _createCardsList(context),
          const SizedBox(height: 25),
          _createSlogan(),
        ],
      ),
    );
  }

  Widget _createCardsList(BuildContext context) {
    List<Report> reports = buildReport();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            TextConstants.discoverAnotherOptions,
            style: TextStyle(
              color: ColorConstants.textBlack,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 160,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              const SizedBox(width: 20),
              HomeCard(
                color: ColorConstants.productCardColor,
                title: TextConstants.productsCardTitle,
                description: TextConstants.productsCardDescription,
                icon: Icons.fastfood_sharp,
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => RegisterDetailsPage(
                          register: DataConstants.products,
                        )))
              ),
              const SizedBox(width: 15),
              HomeCard(
                color: ColorConstants.clientsCardColor,
                title: TextConstants.clientsCardTitle,
                description: TextConstants.clientsCardDescription,
                icon: Icons.people,
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => RegisterDetailsPage(
                          register: DataConstants.clients,
                        )))
              ),
              const SizedBox(width: 15),
              HomeCard(
                color: ColorConstants.providersCardColor,
                title: TextConstants.providersCardTitle,
                description: TextConstants.providersCardDescription,
                icon: Icons.storefront_sharp,
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => RegisterDetailsPage(
                          register: DataConstants.providers,
                        )))
              ),
              const SizedBox(width: 15),
              HomeCard(
                  color: ColorConstants.reportsCardColor,
                  title: TextConstants.reportCardTitle,
                  description: TextConstants.reportCardDescription,
                  icon: Icons.report_sharp,
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => ReportDetailsPage(reports: reports)))
              ),
              const SizedBox(width: 20),
            ],
          ),
        ),
      ],
    );
  }

  List<Report> buildReport() {
    var products = List.generate(
        4,
        (index) => ProductData(
            name: "Produto$index", quantity: index + 3, value: index * 5));
    var reports = List.generate(
        10,
        (index) => Report(
            provider: "Fornecedor$index",
            totalValue: index.toDouble() * 10,
            products: products));
    return reports;
  }

  Widget _createSlogan() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
      child: Row(
        children: [
          Icon(Icons.free_breakfast_outlined),
          SizedBox(width: 20),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  TextConstants.poweredBy,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  TextConstants.companySlogan,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
