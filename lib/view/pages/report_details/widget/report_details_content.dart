import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../../../../const/color_constants.dart';
import '../../../../../model/report.dart';
import '../../../../const/path_constants.dart';
import '../../../../model/product_data.dart';
import '../bloc/reportdetails_bloc.dart';
import '../spending.dart';

class ReportDetailsContent extends StatelessWidget {
  final List<Report> reports;

  const ReportDetailsContent({required this.reports});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: ColorConstants.white,
      child: _buildReportContent(context),
    );
  }

  Widget _buildReportContent(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(physics: const NeverScrollableScrollPhysics(),
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      // Add one stop for each color. Stops should increase from 0 to 1
                      stops: [0.2, 0.7],
                      colors: [
                        Colors.orange,
                        Colors.orangeAccent,
                      ],
                    ),
                  ),
                  height: MediaQuery.of(context).size.height * .40,
                  padding: EdgeInsets.only(top: 20, left: 30, right: 20),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          _createBackButton(context),
                        ],
                      ),
                      SizedBox(height: 30),
                      Text(
                        "Total Faturado",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        r"R$15,990.00",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 34.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .27,
                  right: 20.0,
                  left: 20.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: GridView(
                  primary: false,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 2.5),
                  ),
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Spendings(
                        name: "Total de vendas",
                        amount: "230",
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10.0),
                      child: const Spendings(
                        name: "Total de clientes",
                        amount: r"320",
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .50,
                  bottom: MediaQuery.of(context).size.height - 100,
                  right: 20.0,
                  left: 20.0),
              child: Container(
                height: MediaQuery.of(context).size.height * .50,
                width: MediaQuery.of(context).size.width,
                child: GroupedListView<dynamic, String>(
                  elements: reports,
                  groupBy: (element) => (element).provider,
                  order: GroupedListOrder.ASC,
                  useStickyGroupSeparators: true,
                  groupSeparatorBuilder: (String value) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          value,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "R\$ " + buildTotal(value),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  itemBuilder: (c, element) {
                    return Column(
                      children: [
                        for (ProductData product in (element).products)
                          Card(
                            elevation: 8.0,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 6.0),
                            child: SizedBox(
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                title: Text(product.name),
                                trailing: Text(product.quantity.toString()),
                              ),
                            ),
                          )
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String buildTotal(String value) {
    return reports
            .firstWhere((element) => element.provider == value)
            .totalValue
            .toString();
  }

  Widget _createBackButton(BuildContext context) {
    final bloc = BlocProvider.of<ReportDetailsBloc>(context);
    return Container(
      child: SafeArea(
        child: BlocBuilder<ReportDetailsBloc, ReportDetailsState>(
          builder: (context, state) {
            return GestureDetector(
              child: Container(
                width: 30,
                height: 30,
                child: Image(
                  color: Colors.black,
                  image: AssetImage(PathConstants.back),
                ),
              ),
              onTap: () {
                bloc.add(BackTappedEvent());
              },
            );
          },
        ),
      ),
    );
  }
}
