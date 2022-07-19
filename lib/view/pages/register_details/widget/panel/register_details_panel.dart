import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../const/path_constants.dart';
import '../../../../../model/register.dart' as data;
import '../../../../common_widgets/fitness_button.dart';
import '../../../../common_widgets/fitness_text_field.dart';
import '../../bloc/registerdetails_bloc.dart';

class RegisterDetailsPanel extends StatelessWidget {
  final List<data.Register> register;

  RegisterDetailsPanel({required this.register});

  @override
  Widget build(BuildContext context) {
    return _createPanelData(context);
  }

  Widget _createPanelData(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 15),
        _createRectangle(),
        const SizedBox(height: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _createHeader(),
              const SizedBox(height: 20),
              _createForm(context),
              const SizedBox(height: 20),
              _createSaveButton(context)
            ],
          ),
        ),
      ],
    );
  }

  Widget _createSaveButton(BuildContext context) {
    final bloc = BlocProvider.of<RegisterDetailsBloc>(context);
    return Padding(
        padding: EdgeInsets.all(20),
        child: FitnessButton(
          title: "Salvar",
          onTap: () {
            bloc.uid;
            // TODO: Salvar item no banco e atualizar lista
          },
        ));
  }

  Widget _createRectangle() {
    return Image(image: AssetImage(PathConstants.rectangle));
  }

  Widget _createHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        "Arraste para cadastrar",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _createWorkoutData() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [Text("Text")],
      ),
    );
  }

  Widget _createForm(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bloc = BlocProvider.of<RegisterDetailsBloc>(context);
    return BlocBuilder<RegisterDetailsBloc, RegisterDetailsState>(
      buildWhen: (_, currState) => currState is RegisterData,
      builder: (context, state) {
        return Column(
          children: [
            Container(
              width: double.infinity,
              height: screenWidth * 0.80,
              child: ListView(
                padding: EdgeInsets.all(5),
                scrollDirection: Axis.vertical,
                children: [
                  if (register[0].title == 'Clientes')
                    FitnessTextField(
                      title: "Nome",
                      placeholder: "Adicione um nome",
                      controller: bloc.nameController,
                      textInputAction: TextInputAction.next,
                      errorText: "Erro no campo nome",
                      onTextChanged: () {
                        // bloc.add(OnTextChangedEvent());
                      },
                    ),
                  if (register[0].title == 'Clientes') const SizedBox(height: 20),
                  if (register[0].title == 'Clientes')
                    FitnessTextField(
                      title: "CPF",
                      placeholder: "Adicione o CPF",
                      controller: bloc.documentController,
                      textInputAction: TextInputAction.next,
                      errorText: "Erro no campo CNPJ",
                      onTextChanged: () {
                        // bloc.add(OnTextChangedEvent());
                      },
                    ),
                  if (register[0].title == 'Fornecedores') const SizedBox(height: 20),
                  if (register[0].title == 'Fornecedores')
                    FitnessTextField(
                      title: "Fornecedor",
                      placeholder: "Adicione o nome da empresa",
                      controller: bloc.nameController,
                      textInputAction: TextInputAction.next,
                      errorText: "Erro no campo fornecedor",
                      onTextChanged: () {
                        // bloc.add(OnTextChangedEvent());
                      },
                    ),
                  if (register[0].title == 'Fornecedores') const SizedBox(height: 20),
                  if (register[0].title == 'Fornecedores')
                    FitnessTextField(
                      title: "CNPJ",
                      placeholder: "Adicione o CNPJ",
                      controller: bloc.documentController,
                      textInputAction: TextInputAction.next,
                      errorText: "Erro no campo CNPJ",
                      onTextChanged: () {
                        // bloc.add(OnTextChangedEvent());
                      },
                    ),
                  if (register[0].title == 'Fornecedores') const SizedBox(height: 20),
                  if (register[0].title == 'Fornecedores')
                    FitnessTextField(
                      title: "Contato",
                      placeholder: "Adicione o contato",
                      controller: bloc.contactController,
                      textInputAction: TextInputAction.next,
                      errorText: "Erro no campo Contato",
                      onTextChanged: () {
                        // bloc.add(OnTextChangedEvent());
                      },
                    ),
                  if (register[0].title == 'Clientes' ||
                      register[0].title == 'Fornecedores')
                    const SizedBox(height: 20),
                  if (register[0].title == 'Clientes' ||
                      register[0].title == 'Fornecedores')
                    FitnessTextField(
                      title: "Telefone",
                      placeholder: "Adicione o telefone",
                      controller: bloc.phoneNumberController,
                      textInputAction: TextInputAction.next,
                      errorText: "Erro no campo telefone",
                      onTextChanged: () {
                        // bloc.add(OnTextChangedEvent());
                      },
                    ),
                  if (register[0].title == 'Produtos') const SizedBox(height: 20),
                  if (register[0].title == 'Produtos')
                    FitnessTextField(
                      title: "Produto",
                      placeholder: "Adicione o nome do produto",
                      controller: bloc.nameController,
                      textInputAction: TextInputAction.next,
                      errorText: "Erro no campo produto",
                      onTextChanged: () {
                        // bloc.add(OnTextChangedEvent());
                      },
                    ),
                  if (register[0].title == 'Produtos') const SizedBox(height: 20),
                  if (register[0].title == 'Produtos')
                    FitnessTextField(
                      title: "Quantidade",
                      placeholder: "Adicione uma quantidade",
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      controller: bloc.quantityController,
                      errorText: "Erro no campo quantidade",
                      onTextChanged: () {
                        // bloc.add(OnTextChangedEvent());
                      },
                    ),
                  if (register[0].title == 'Produtos') const SizedBox(height: 20),
                  if (register[0].title == 'Produtos')
                    FitnessTextField(
                      title: "Valor",
                      placeholder: "Adicione o valor",
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      controller: bloc.valueController,
                      errorText: "Erro no campo valor",
                      onTextChanged: () {
                        // bloc.add(OnTextChangedEvent());
                      },
                    ),
                  if (register[0].title == 'Produtos') const SizedBox(height: 20),
                  if (register[0].title == 'Produtos')
                    FitnessTextField(
                      title: "Descrição",
                      placeholder: "Adicione uma descrição",
                      textInputAction: TextInputAction.next,
                      controller: bloc.descriptionController,
                      errorText: "Erro no campo descrição",
                      onTextChanged: () {
                        // bloc.add(OnTextChangedEvent());
                      },
                    )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
