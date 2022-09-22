import 'package:comanda_nfc/repositories/cloud_functions.dart';
import 'package:comanda_nfc/view/pages/register_details/widget/panel/register_details_panel.dart';
import 'package:comanda_nfc/view/pages/register_details/widget/register_details_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../../const/color_constants.dart';
import '../../../../model/enums/cardType.dart';
import '../../../../model/register.dart';
import '../bloc/registerdetails_bloc.dart';

class RegisterDetailsContent extends StatelessWidget {
  final CardType? cardType;

  const RegisterDetailsContent({required this.cardType});

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
    Stream<List<Register>>? list = CloudFunctions().getByCardType(cardType); // TODO: Parece que esta pegando estatico ( se entrar em qlqr um, será o ultimo salvo )
    return SlidingUpPanel(
      controller: bloc.panelController,
      panel: RegisterDetailsPanel(register: list, cardType: cardType),
      body: RegisterDetailsBody(register: list, cardType: cardType),
      minHeight: MediaQuery.of(context).size.height * 0.11,
      maxHeight: MediaQuery.of(context).size.height * 0.80,
      isDraggable: true,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(50),
        topRight: Radius.circular(50),
      ),
    );
  }
}
