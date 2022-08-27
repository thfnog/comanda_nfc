import 'package:comanda_nfc/model/enums/cardType.dart';
import 'package:comanda_nfc/view/pages/register_details/widget/panel/register_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../const/color_constants.dart';
import '../../../../const/path_constants.dart';
import '../../../../model/register.dart';
import '../bloc/registerdetails_bloc.dart';

class RegisterDetailsBody extends StatelessWidget {
  final Stream<List<Register>>? register;

  const RegisterDetailsBody({required this.register});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Register>>(
      stream: register,
      builder: (BuildContext context, AsyncSnapshot<List<Register>> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return buildContainer(context, snapshot!.data);
      },
    );
  }

  Container buildContainer(BuildContext context, List<Register>? data) {
    return Container(
    height: double.infinity,
    width: double.infinity,
    color: ColorConstants.white,
    child: Stack(
      children: [
        Positioned.fill(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _createBackButton(context),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  data?[0].type.description ?? '' + " listados para gerenciar:",
                  style: TextStyle(
                    color: ColorConstants.textBlack,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _createRegisterList(context, data)
            ],
          ),
        ),

      ],
    ),
  );
  }

  Widget _createBackButton(BuildContext context) {
    final bloc = BlocProvider.of<RegisterDetailsBloc>(context);
    return Container(
      padding: EdgeInsets.fromLTRB(10, 20, 0, 10),
      child: SafeArea(
        child: BlocBuilder<RegisterDetailsBloc, RegisterDetailsState>(
          builder: (context, state) {
            return GestureDetector(
              child: Container(
                width: 30,
                height: 30,
                child: Image(
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

  Widget _createRegisterList(BuildContext context, List<Register>? data) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: RegisterList(register: data, context: context),
      ),
    );
  }
}
