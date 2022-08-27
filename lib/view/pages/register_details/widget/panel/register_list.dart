import 'package:comanda_nfc/const/path_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../const/color_constants.dart';
import '../../../../../model/register.dart';
import '../../bloc/registerdetails_bloc.dart';

class RegisterList extends StatelessWidget {
  final List<Register>? register;
  final BuildContext context;

  const RegisterList({super.key, required this.register, required this.context});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(top: 10, bottom: 100),
      itemCount: register?.length ?? 0,
      itemBuilder: (context, index) {
        return RegisterCell(
          currentRegister: register?[index],
          nextRegister: index == (register?.length ?? 0) - 1 ? null : register?[index + 1]
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 15);
      },
    );
  }
}

class RegisterCell extends StatelessWidget {
  final Register? currentRegister;
  final Register? nextRegister;

  const RegisterCell({
    super.key,
    required this.currentRegister,
    required this.nextRegister,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<RegisterDetailsBloc>(context);
    return InkWell(
      borderRadius: BorderRadius.circular(40),
      onTap: () {
        bloc.uid = currentRegister?.uid;
        bloc.nameController.text = currentRegister?.name ?? '';
        bloc.documentController.text = currentRegister?.document ?? '';
        currentRegister?.additionalInfo.forEach((key, value) {
          if (key == 'responsible') bloc.contactController.text = value;
          if (key == 'phoneNumber') bloc.phoneNumberController.text = value;
          if (key == 'quantity') bloc.quantityController.text = value;
          if (key == 'value') bloc.valueController.text = value;
          if (key == 'description') bloc.descriptionController.text = value;
        });

        if(bloc.panelController.isPanelClosed) bloc.panelController.animatePanelToPosition(1.0);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(left: 10, right: 25, top: 10, bottom: 10),
        decoration: BoxDecoration(
          color: ColorConstants.white,
          borderRadius: BorderRadius.circular(10),
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
            _createImage(),
            const SizedBox(width: 10),
            Expanded(
              child: _createProductTextInfo(),
            ),
            const SizedBox(width: 10),
            _createRightArrow(),
          ],
        ),
      ),
    );
  }

  Widget _createImage() {
    return Container(
      width: 75,
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        image: const DecorationImage(
          image: AssetImage(PathConstants.pilates),
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _createProductTextInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          currentRegister?.name ?? '',
          style: const TextStyle(
            color: ColorConstants.textColor,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        if (currentRegister?.document.isNotEmpty ?? false) Text(
          currentRegister?.document ?? '',
          style: const TextStyle(
            color: ColorConstants.textColor,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        for(String info in currentRegister?.additionalInfo.values ?? [])
          Text(
            info,
            style: const TextStyle(
              color: ColorConstants.textBlack,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
      ],
    );
  }

  Widget _createRightArrow() {
    return const RotatedBox(
      quarterTurns: 2,
      child: Image(
        image: AssetImage(PathConstants.back),
      ),
    );
  }
}
