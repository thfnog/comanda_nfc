import 'package:comanda_nfc/const/text_constants.dart';
import 'package:comanda_nfc/model/product_data.dart';
import 'package:comanda_nfc/view/common_widgets/custom_control_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../const/path_constants.dart';
import '../../../../../model/enums/cardType.dart';
import '../../../../../model/person_data.dart';
import '../../../../../model/provider_data.dart';
import '../../../../../model/register.dart';
import '../../../../../repositories/cloud_functions.dart';
import '../../../../common_widgets/custom_button.dart';
import '../../../../common_widgets/custom_text_field.dart';
import '../../bloc/registerdetails_bloc.dart';

class RegisterDetailsPanel extends StatelessWidget {
  final Stream<List<Register>>? register;
  final CardType? cardType;

  const RegisterDetailsPanel({super.key, required this.register, required this.cardType});

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

        return _createPanelData(context, snapshot.data);
      },
    );
  }

  Widget _createPanelData(BuildContext context, List<Register>? data) {
    return Column(
      children: [
        const SizedBox(height: 15),
        _createRectangle(),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _createHeader(context),
              _createForm(context, data),
              _createSaveButton(context, data)
            ],
          ),
        ),
      ],
    );
  }

  Widget _deleteItemButton(BuildContext context) {
    final bloc = BlocProvider.of<RegisterDetailsBloc>(context);
    return CustomControlButton(
        title: "Excluir Item",
        iconData: Icons.delete_forever_rounded,
        onTap: () {
          CloudFunctions().
            deleteByCardType(CardType.products, bloc.nameController.value.text);
          cleanFields(bloc);
          clonePanel(bloc);
        });
  }

  Widget _cleanFieldsButton(BuildContext context) {
    final bloc = BlocProvider.of<RegisterDetailsBloc>(context);
    return CustomControlButton(
        title: "Novo Item",
        iconData: Icons.clear_all_outlined,
        onTap: () {
          cleanFields(bloc);
      });
  }

  void cleanFields(RegisterDetailsBloc bloc) {
    bloc.nameController.clear();
    bloc.documentController.clear();
    bloc.contactController.clear();
    bloc.phoneNumberController.clear();
    bloc.quantityController.clear();
    bloc.valueController.clear();
    bloc.descriptionController.clear();
  }

  Widget _closePanelButton(BuildContext context) {
    final bloc = BlocProvider.of<RegisterDetailsBloc>(context);
    return CustomControlButton(
        title: "Fechar Tela",
        iconData: Icons.close,
        onTap: () {
          clonePanel(bloc);
        });
  }

  void clonePanel(RegisterDetailsBloc bloc) {
    if (bloc.panelController.isAttached &&
        bloc.panelController.isPanelOpen) {
      bloc.panelController.animatePanelToPosition(0.0);
    }
  }

  Widget _createSaveButton(BuildContext context, List<Register>? data) {
    final bloc = BlocProvider.of<RegisterDetailsBloc>(context);
    return Padding(
        padding: const EdgeInsets.all(20),
        child: CustomButton(
          title: TextConstants.saveRegisterCardButton,
          onTap: () {
            clonePanel(bloc);

            switch (cardType) {
              case CardType.products:
                saveProducts(bloc);
                break;
              case CardType.clients:
                saveClients(bloc);
                break;
              case CardType.providers:
                saveProviders(bloc);
                break;
              default:
                break;
            }
          },
        ));
  }

  void saveProducts(RegisterDetailsBloc bloc) {
    var productData = ProductData(
        name: bloc.nameController.value.text,
        quantity: int.tryParse(bloc.quantityController.value.text) ?? (0),
        value: double.tryParse(bloc.valueController.value.text) ?? (0),
        description: bloc.descriptionController.value.text,
        bloc.uid);
    CloudFunctions().saveByCardType(CardType.products, productData.toMap());
  }

  void saveClients(RegisterDetailsBloc bloc) {
    var personData = PersonData(
        name: bloc.nameController.value.text,
        cpf: bloc.documentController.value.text,
        phoneNumber: bloc.phoneNumberController.value.text,
        bloc.uid);
    CloudFunctions().saveByCardType(CardType.clients, personData.toMap());
  }

  void saveProviders(RegisterDetailsBloc bloc) {
    var providerData = ProviderData(
        providerName: bloc.nameController.value.text,
        cnpj: bloc.documentController.value.text,
        responsible: bloc.contactController.value.text,
        phoneNumber: bloc.phoneNumberController.value.text,
        bloc.uid);
    CloudFunctions().saveByCardType(CardType.providers, providerData.toMap());
  }

  Widget _createRectangle() {
    return const Image(image: AssetImage(PathConstants.rectangle));
  }

  Widget _createHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(
            Icons.upload,
            size: 24.0,
            color: Colors.black,
          ),
          label: Text(
            textAlign: TextAlign.center,
            TextConstants.panelRegisterCardDescription,
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [_cleanFieldsButton(context), _deleteItemButton(context), _closePanelButton(context)],
        )
      ],
    );
  }

  Widget _createForm(BuildContext context, List<Register>? data) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bloc = BlocProvider.of<RegisterDetailsBloc>(context);
    return BlocBuilder<RegisterDetailsBloc, RegisterDetailsState>(
      buildWhen: (_, currState) => currState is RegisterData,
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: screenWidth * 0.80,
              child: buildListView(bloc, data),
            ),
          ],
        );
      },
    );
  }

  Widget buildListView(RegisterDetailsBloc bloc, List<Register>? data) {
    if (cardType == CardType.products) {
      return productsListView(bloc);
    } else {
      return clientListView(bloc, data); // TODO: Precisa passar de alguma forma o tipo aqui pra construir os campos
    }
  }

  Widget productsListView(RegisterDetailsBloc bloc) {
    return ListView(
      padding: const EdgeInsets.all(5),
      scrollDirection: Axis.vertical,
      children: [
        const SizedBox(height: 20),
        CustomTextField(
          title: "Produto",
          placeholder: "Adicione o nome do produto",
          controller: bloc.nameController,
          textInputAction: TextInputAction.next,
          errorText: "Erro no campo produto",
          onTextChanged: () {
            bloc.add(OnTextChangedEvent());
          },
        ),
        const SizedBox(height: 20),
        CustomTextField(
          title: "Quantidade",
          placeholder: "Adicione uma quantidade",
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          controller: bloc.quantityController,
          errorText: "Erro no campo quantidade",
          onTextChanged: () {
            bloc.add(OnTextChangedEvent());
          },
        ),
        const SizedBox(height: 20),
        CustomTextField(
          title: "Valor",
          placeholder: "Adicione o valor",
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          controller: bloc.valueController,
          errorText: "Erro no campo valor",
          onTextChanged: () {
            bloc.add(OnTextChangedEvent());
          },
        ),
        const SizedBox(height: 20),
        CustomTextField(
          title: "Descrição",
          placeholder: "Adicione uma descrição",
          textInputAction: TextInputAction.next,
          controller: bloc.descriptionController,
          errorText: "Erro no campo descrição",
          onTextChanged: () {
            bloc.add(OnTextChangedEvent());
          },
        )
      ],
    );
  }

  Widget clientListView(RegisterDetailsBloc bloc, List<Register>? data) {
    return ListView(
      padding: const EdgeInsets.all(5),
      scrollDirection: Axis.vertical,
      children: [
        if (cardType == CardType.clients) const SizedBox(height: 20),
        if (cardType == CardType.clients)
          CustomTextField(
            title: "Nome",
            placeholder: "Adicione um nome",
            controller: bloc.nameController,
            textInputAction: TextInputAction.next,
            errorText: "Erro no campo nome",
            onTextChanged: () {
              // bloc.add(OnTextChangedEvent());
            },
          ),
        if (cardType == CardType.clients) const SizedBox(height: 20),
        if (cardType == CardType.clients)
          CustomTextField(
            title: "CPF",
            placeholder: "Adicione o CPF",
            controller: bloc.documentController,
            textInputAction: TextInputAction.next,
            errorText: "Erro no campo CNPJ",
            onTextChanged: () {
              // bloc.add(OnTextChangedEvent());
            },
          ),
        if (cardType == CardType.providers) const SizedBox(height: 20),
        if (cardType == CardType.providers)
          CustomTextField(
            title: "Fornecedor",
            placeholder: "Adicione o nome da empresa",
            controller: bloc.nameController,
            textInputAction: TextInputAction.next,
            errorText: "Erro no campo fornecedor",
            onTextChanged: () {
              // bloc.add(OnTextChangedEvent());
            },
          ),
        if (cardType == CardType.providers) const SizedBox(height: 20),
        if (cardType == CardType.providers)
          CustomTextField(
            title: "CNPJ",
            placeholder: "Adicione o CNPJ",
            controller: bloc.documentController,
            textInputAction: TextInputAction.next,
            errorText: "Erro no campo CNPJ",
            onTextChanged: () {
              // bloc.add(OnTextChangedEvent());
            },
          ),
        if (cardType == CardType.providers) const SizedBox(height: 20),
        if (cardType == CardType.providers)
          CustomTextField(
            title: "Contato",
            placeholder: "Adicione o contato",
            controller: bloc.contactController,
            textInputAction: TextInputAction.next,
            errorText: "Erro no campo Contato",
            onTextChanged: () {
              // bloc.add(OnTextChangedEvent());
            },
          ),
        if (cardType == CardType.clients || cardType == CardType.providers)
          const SizedBox(height: 20),
        if (cardType == CardType.clients || cardType == CardType.providers)
          CustomTextField(
            title: "Telefone",
            placeholder: "Adicione o telefone",
            controller: bloc.phoneNumberController,
            textInputAction: TextInputAction.next,
            errorText: "Erro no campo telefone",
            onTextChanged: () {
              // bloc.add(OnTextChangedEvent());
            },
          ),
      ],
    );
  }
}
