import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../common_widgets/custom_text_field.dart';

// TODO: o SALVAR será quando aproximar o cartão
class RegisterClientForm extends StatelessWidget {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController cpfController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height / 3,
        width: MediaQuery.of(context).size.width,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SafeArea(
                child: Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            CustomTextField(
                              title: "CPF",
                              placeholder: "Adicione o CPF",
                              controller: cpfController,
                              textInputAction: TextInputAction.next,
                              errorText: "Erro no campo CPF",
                              onTextChanged: () {
                                // bloc.add(OnTextChangedEvent());
                              },
                            ),
                            const SizedBox(height: 20),
                            CustomTextField(
                              title: "Telefone",
                              placeholder: "Adicione o telefone",
                              controller: phoneNumberController,
                              textInputAction: TextInputAction.next,
                              errorText: "Erro no campo telefone",
                              onTextChanged: () {
                                // bloc.add(OnTextChangedEvent());
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ))));
  }
}
