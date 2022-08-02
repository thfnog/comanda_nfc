import 'package:comanda_nfc/const/data_constants.dart';
import 'package:comanda_nfc/model/product_data.dart';
import 'package:comanda_nfc/view/pages/invoice/folder_clipper.dart';
import 'package:comanda_nfc/view/pages/invoice/invoice_clipper.dart';
import 'package:flutter/material.dart';

import '../../../model/invoice_data.dart';
import 'package:intl/intl.dart';

Color defaultColor = const Color(0XFF835454);

class InvoicePage extends StatelessWidget {
  const InvoicePage({Key? key}) : super(key: key);

  InvoiceData get _invoiceData => DataConstants.invoiceData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: BackButton(
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Resumo da Fatura"),
        actions: [
          IconButton(onPressed: () => _pixQRCode(context), icon: const Icon(Icons.qr_code))
        ],
      ),
      body: ClipPath(
        clipper: FolderClipper(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: const Color(0XFFEAE7EA),
          padding: const EdgeInsets.only(top: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              PhysicalModel(
                  color: Colors.transparent,
                  elevation: 32,
                  shadowColor: Colors.black,
                  child: Container(height: MediaQuery.of(context).size.height * .64,
                      padding: const EdgeInsets.only(left: 16.0),
                      child: _buildContent(context)
                  )
              ),
              // const Expanded(child: SizedBox.shrink()),
              // _buildActionButton(context)
            ],
          ),
        ),
      ),
      floatingActionButton: _buildActionButton(context),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Fatura para",
                  style: Theme.of(context).textTheme.bodyText2),
              Text(_invoiceData.personData.name,
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: defaultColor))
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Total Calculado",
                  style: Theme.of(context).textTheme.bodyText2),
              Text("R\$ ${_invoiceData.totalAmount}",
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: defaultColor))
            ],
          )
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ClipPath(
            clipper: InvoiceContentClipper(),
            child: Container(
              color: const Color(0XFFDCA5B3),
              height: MediaQuery.of(context).size.height * 0.14,
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  const Icon(
                    Icons.monetization_on,
                    color: Colors.black54,
                  ),
                  Text("Fatura", style: Theme.of(context).textTheme.headline4)
                ],
              ),
            ),
          ),
          ClipPath(
            clipper: InvoiceContentClipper(),
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.file_copy, color: defaultColor),
                      Text("Detalhes da Fatura",
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(color: defaultColor))
                    ],
                  ),
                  SizedBox(height: 12),
                  _buildContentInfo(context),
                  Container(
                    width: double.infinity,
                    height: .5,
                    color: Colors.black38,
                    margin: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  _buildContentBody(context),
                  Container(
                    width: double.infinity,
                    height: .5,
                    color: Colors.black38,
                    margin: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  _buildContentSummary(context)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildContentInfo(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Dados do cliente", style: Theme.of(context).textTheme.caption),
            SizedBox(height: 4),
            Text(_invoiceData.personData.cpf,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: defaultColor))
          ],
        )),
        Container(
          width: .5,
          color: Colors.black38,
          height: 32,
        ),
        Expanded(
          child: Container(
            alignment: Alignment.centerRight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Data da Fatura",
                    style: Theme.of(context).textTheme.caption),
                SizedBox(height: 4),
                Text(DateFormat('dd-MM-yyyy – kk:mm').format(_invoiceData.datetime),
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: defaultColor))
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildContentBody(BuildContext context) {
    final fullWidth = MediaQuery.of(context).size.width;
    final rowWidth = fullWidth * 0.9;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              width: rowWidth * .2,
              child: Text("Itens Consumidos", style: Theme.of(context).textTheme.caption),
            ),
            Container(
              alignment: Alignment.center,
              width: rowWidth * .2,
              child: Text("Quantidade", style: Theme.of(context).textTheme.caption),
            ),
            Container(
              alignment: Alignment.centerLeft,
              width: rowWidth * .2,
              child: Text("Valor", style: Theme.of(context).textTheme.caption),
            ),
          ],
        ),
        for(ProductData product in _invoiceData.personData.products)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                width: rowWidth * .2,
                child: Text(product.name,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.black54)),
              ),
              Container(
                alignment: Alignment.center,
                width: rowWidth * .2,
                child: Text("${product.quantity}",textAlign: TextAlign.left,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: defaultColor)),
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: rowWidth * .2,
                // width: 100,
                child: Text("R\$${product.value * product.quantity}",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: defaultColor)),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildContentSummary(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Subtotal",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.black54)),
            Container(
              width: 100,
              child: Text("R\$${_invoiceData.totalAmount}",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: defaultColor)),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text.rich(TextSpan(text: "Desconto", children: [
              TextSpan(
                  text: " 0%",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.blueAccent))
            ])),
            Container(
              width: 100,
              child: Text("R\$0",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: defaultColor)),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Valor Total",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.black54)),
            Container(
              width: 100,
              child: Text("R\$${_invoiceData.totalAmount}",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.blueAccent, fontSize: 18)),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildActionButton(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 2,
            child: TextButton.icon(
                onPressed: () => _newCard(context),
                icon: Icon(Icons.add_card_sharp, color: defaultColor),
                label: Text("Ler Comanda", style: TextStyle(color: defaultColor)))),
        Expanded(
            flex: 3,
            child: Container(
                color: Colors.orangeAccent,
                child: TextButton(
                    onPressed: () => _closeInvoice(context),
                    child: Text("Fechar Fatura",
                        style: TextStyle(color: defaultColor)))))
      ],
    );
  }

  void _newCard(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text("Aproxime a comanda."),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('FECHAR'),
            ),
          ],
        );
      },
    );
  }

  void _closeInvoice(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text("Deseja fechar a comanda?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('SIM'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('FECHAR'),
            ),
          ],
        );
      },
    );
  }

  void _pixQRCode(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            height: MediaQuery.of(context).size.height * .4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("IMAGEM QRCODE"),
                SizedBox(height: 20,),
                Text("CNPJ")
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('FECHAR'),
            ),
          ],
        );
      },
    );
  }

}
