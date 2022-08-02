import 'package:comanda_nfc/view/pages/register_details/widget/panel/register_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../const/color_constants.dart';
import '../../../../const/path_constants.dart';
import '../../../../model/register.dart' as data;
import '../../register_details/bloc/registerdetails_bloc.dart';

class RegisterDetailsBody extends StatelessWidget {
  final List<data.Register> register;
  RegisterDetailsBody({required this.register});

  @override
  Widget build(BuildContext context) {
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
                    register[0].title + " listados para gerenciar:",
                    style: TextStyle(
                      color: ColorConstants.textBlack,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                _createRegisterList(context)
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

  Widget _createRegisterList(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: RegisterList(register: register, context: context),
      ),
    );
  }
}
