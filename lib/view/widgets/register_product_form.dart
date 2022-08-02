import 'package:comanda_nfc/const/data_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../const/color_constants.dart';

// TODO: o SALVAR será quando aproximar o cartão

class RegisterProductForm extends StatefulWidget {
  @override
  _RegisterProductFormState createState() => _RegisterProductFormState();
}

class _RegisterProductFormState extends State<RegisterProductForm> {
  Map<TYPE, int> selectedItems = {};

  @override
  void initState() {
    super.initState();

    setState(() {
      selectedItems[TYPE.QUANTITY] = 0;
      selectedItems[TYPE.PRODUCT] = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery
            .of(context)
            .size
            .height / 2,
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: Center(
            child: Column(
              children: [
                Text("Selecione um produto"),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: DataConstants.products.length,
                    itemBuilder: (context, index) {
                      return buildCell(
                          context, DataConstants.productsRegister[index].name,
                          index, TYPE.PRODUCT);
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 15);
                    },
                  ),
                ),
                SizedBox(height: 20),
                Text("Selecione a quantidade"),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: DataConstants.products[0].quantity,
                    itemBuilder: (context, index) {
                      return buildCell(
                          context, "${index + 1}", index, TYPE.QUANTITY);
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 15);
                    },
                  ),
                ),
                SizedBox(height: 50),
                Text("Resumo"),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Produto: ${DataConstants.products[selectedItems[TYPE.PRODUCT]!].name}"),
                    Text("Quantidade: ${selectedItems[TYPE.QUANTITY]! + 1}"),
                  ],
                )
              ],
            )
        ));
  }

  GestureDetector buildCell(BuildContext context, String title, int index,
      TYPE type) {
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    return GestureDetector(
      onTap: () =>
      {
        setState(() {
          selectedItems[type] = index;
        })
      },
      child: Container(
          margin: EdgeInsets.only(right: 10),
          height: screenHeight * 0.3,
          width: screenWidth * 0.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: selectedItems[type] == index ? Colors.deepOrangeAccent : Colors.orange,
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: ColorConstants.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          )),
    );
  }
}

enum TYPE {
  PRODUCT,
  QUANTITY
}
