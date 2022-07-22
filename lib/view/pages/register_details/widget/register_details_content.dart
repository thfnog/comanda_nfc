import 'package:comanda_nfc/view/pages/register_details/widget/panel/register_details_panel.dart';
import 'package:comanda_nfc/view/pages/register_details/widget/register_details_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../../const/color_constants.dart';
import '../../../../model/register.dart';
import '../bloc/registerdetails_bloc.dart';

class RegisterDetailsContent extends StatelessWidget {
  final List<Register> register;

  const RegisterDetailsContent({required this.register});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: ColorConstants.white,
      child: _createSlidingUpPanel(context),
    );
  }

  Widget _createSlidingUpPanel(BuildContext context) {
    final bloc = BlocProvider.of<RegisterDetailsBloc>(context);
    return SlidingUpPanel(
      controller: bloc.panelController,
      panel: RegisterDetailsPanel(register: register),
      body: RegisterDetailsBody(register: register),
      minHeight: MediaQuery.of(context).size.height * 0.20,
      maxHeight: MediaQuery.of(context).size.height * 0.80,
      isDraggable: true,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(50),
        topRight: Radius.circular(50),
      ),
    );
  }
}
