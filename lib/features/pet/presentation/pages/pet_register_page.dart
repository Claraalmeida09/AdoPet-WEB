import 'package:adopet/core/utils/nav.dart';
import 'package:adopet/core/values/colors_adopet.dart';
import 'package:adopet/core/values/images_adopet.dart';
import 'package:adopet/core/values/text_style_adopet.dart';
import 'package:adopet/core/values/texts_adopet.dart';
import 'package:adopet/core/widgets/adopet_toast.dart';
import 'package:adopet/core/widgets/button_geral.dart';
import 'package:adopet/core/widgets/column_form.dart';
import 'package:adopet/core/widgets/form_register.dart';
import 'package:adopet/core/widgets/loading_widget.dart';
import 'package:adopet/core/widgets/success_widget.dart';
import 'package:adopet/core/widgets/validator_dialog.dart';
import 'package:adopet/features/home/presentation/pages/home_page.dart';
import 'package:adopet/features/pet/domain/entities/pet.dart';
import 'package:adopet/features/pet/domain/entities/pet_and_users.dart';
import 'package:adopet/features/pet/presentation/bloc/pet_bloc.dart';
import 'package:adopet/features/pet/presentation/widget/radio_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';

class PetRegisterPage extends StatefulWidget {
  const PetRegisterPage({Key? key, this.userId, this.petAndUsers})
      : super(key: key);
  final int? userId;
  final PetAndUsers? petAndUsers;

  @override
  _PetRegisterPageState createState() => _PetRegisterPageState();
}

class _PetRegisterPageState extends State<PetRegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _tPetName = TextEditingController();
  final _tDescription = TextEditingController();

  bool get editModePet => widget.petAndUsers != null && widget.userId != null;

  PetAndUsers? get petAndUsers => widget.petAndUsers;

  String? _groupValue;
  String? _groupValueStatus;

  late PetBloc registerPetBloc;

  ValueChanged<String?> _valueChangedHandler() {
    return (value) => setState(() => _groupValue = value!);
  }

  ValueChanged<String?> _valueChangedHandlerStatus(String status) {
    return (value) => setState(() {
          _groupValueStatus = value!;
        });
  }

  @override
  void initState() {
    super.initState();

    registerPetBloc = PetBloc(
      registerPet: sl(),
      getCachedUser: sl(),
      editPet: sl(),
    );

    if (editModePet) {
      _tPetName.text = petAndUsers!.petName;
      _tDescription.text = petAndUsers!.description ?? '';
      _groupValue = petAndUsers!.type;
      _groupValueStatus = convertNumberInStatus(petAndUsers!.status);
    }
  }

  @override
  void dispose() {
    registerPetBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      listener: _handleStateUpdate,
      bloc: registerPetBloc,
      child: _body(context),
    );
  }

  Future<void> _handleStateUpdate(BuildContext context, PetState state) async {
    if (state is Loading) {
      AdoPetToast.showToastWithWidgetAndMessage(
        context,
        TextsAdoPet.defaultLoadingMessage,
        const LoadingWidget(),
      );
    }

    if (state is Created) {
      AdoPetToast.showToastWithWidgetAndMessage(
        context,
        TextsAdoPet.successOnRegisterPet,
        const SuccessWidget(),
        onDismiss: () => push(
          context,
          const HomePage(),
        ),
      );
    }

    if (state is Edited) {
      AdoPetToast.showToastWithWidgetAndMessage(
        context,
        TextsAdoPet.successOnEdit,
        const SuccessWidget(),
        onDismiss: () => push(
          context,
          const HomePage(),
        ),
      );
    }

    if (state is Error) {
      AdoPetToast.showToastWithMessageAndIcon(
          context, state.message, Icons.error,
          color: ColorsAdoPet.obrigatory, duration: 5, width: 300);
    }
  }

  _body(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Stack(
              children: [
                _formRegister(),
                _image(),
              ],
            )
          ],
        ),
      ),
    );
  }

  _image() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * .50,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            color: ColorsAdoPet.header,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(250),
              bottomRight: Radius.circular(250),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(ImagesAdoPet.headerRemove),
              Text(
                TextsAdoPet.together,
                style: TextStyleAdoPet.titleBold25,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 100),
                child: Text(
                  TextsAdoPet.includPets,
                  style: TextStyleAdoPet.headingWhite,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  _formRegister() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: ColorsAdoPet.blueLogo,
      child: Padding(
        padding:
            EdgeInsets.only(right: MediaQuery.of(context).size.width * .10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Image.asset(ImagesAdoPet.logoNome),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .05,
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .03,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      editModePet ? _textEdit() : Container(),
                      ColumnForm(
                        style: TextStyleAdoPet.bodyBoldWhite,
                        text: TextsAdoPet.namePet,
                        obrigatory: TextsAdoPet.asterisk,
                        widget: FormRegister(
                          maxLines: 1,
                          hintColor: ColorsAdoPet.hintText1,
                          filled: true,
                          color: ColorsAdoPet.white,
                          controller: _tPetName,
                          obscureText: false,
                          width: MediaQuery.of(context).size.width * .20,
                          enabled: true,
                          hintText: TextsAdoPet.hintPetName,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .03,
                      ),
                      Row(
                        children: [
                          MyRadioOption<String>(
                            value: 'GATO',
                            groupValue: _groupValue,
                            onChanged: _valueChangedHandler(),
                            label: 'GATO',
                            fontSize: 18,
                            widthContainer: 120,
                          ),
                          MyRadioOption<String>(
                            value: 'CACHORRO',
                            groupValue: _groupValue,
                            onChanged: _valueChangedHandler(),
                            label: 'CACHORRO',
                            fontSize: 18,
                            widthContainer: 120,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .03,
                      ),
                      ColumnForm(
                        style: TextStyleAdoPet.bodyBoldWhite,
                        text: TextsAdoPet.description,
                        obrigatory: TextsAdoPet.asterisk,
                        widget: FormRegister(
                          maxLines: 5,
                          hintColor: ColorsAdoPet.hintText1,
                          filled: true,
                          color: ColorsAdoPet.white,
                          controller: _tDescription,
                          obscureText: false,
                          width: MediaQuery.of(context).size.width * .20,
                          enabled: true,
                          hintText: TextsAdoPet.hintDescription,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .03,
                      ),
                      editModePet
                          ? Row(
                              children: [
                                MyRadioOption<String>(
                                  value: 'Disponível para adoção',
                                  groupValue: _groupValueStatus,
                                  onChanged: _valueChangedHandlerStatus('0'),
                                  label: 'Disponível para adoção',
                                  fontSize: 15,
                                  widthContainer: 200,
                                ),
                                MyRadioOption<String>(
                                  value: 'Adotado',
                                  groupValue: _groupValueStatus,
                                  onChanged: _valueChangedHandlerStatus('1'),
                                  label: 'Adotado',
                                  fontSize: 15,
                                  widthContainer: 200,
                                ),
                              ],
                            )
                          : Container(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .03,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * .13),
                        child: editModePet
                            ? Row(
                                children: [
                                  ButtonGeral(
                                      icon: false,
                                      text: TextsAdoPet.cancel,
                                      width: 100,
                                      height: 40,
                                      fontSize: 14,
                                      onPressed: () =>
                                          push(context, const HomePage()),
                                      color: ColorsAdoPet.obrigatory),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.02,
                                  ),
                                  ButtonGeral(
                                      icon: false,
                                      text: TextsAdoPet.edit,
                                      width: 100,
                                      height: 40,
                                      fontSize: 14,
                                      onPressed: () async {
                                        final canSaveList = canSave();
                                        if (canSaveList.isEmpty) {
                                          editPet();
                                        } else {
                                          await showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return ValidatorDialog(
                                                canSaveList: canSaveList,
                                                title:
                                                    TextsAdoPet.errorRegister,
                                                subtitle:
                                                    TextsAdoPet.subtitleError,
                                                text: TextsAdoPet.pleaseFinish,
                                              );
                                            },
                                          );
                                        }
                                      },
                                      color: ColorsAdoPet.yellowLogo)
                                ],
                              )
                            : Row(
                                children: [
                                  ButtonGeral(
                                      icon: false,
                                      text: TextsAdoPet.cancel,
                                      width: 100,
                                      height: 40,
                                      fontSize: 14,
                                      onPressed: () =>
                                          push(context, const HomePage()),
                                      color: ColorsAdoPet.obrigatory),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.02,
                                  ),
                                  ButtonGeral(
                                      icon: false,
                                      text: TextsAdoPet.registerUser,
                                      width: 100,
                                      height: 40,
                                      fontSize: 14,
                                      onPressed: () async {
                                        final canSaveList = canSave();
                                        if (canSaveList.isEmpty) {
                                          registerPet();
                                        } else {
                                          await showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return ValidatorDialog(
                                                canSaveList: canSaveList,
                                                title:
                                                    TextsAdoPet.errorRegister,
                                                subtitle:
                                                    TextsAdoPet.subtitleError,
                                                text: TextsAdoPet.pleaseFinish,
                                              );
                                            },
                                          );
                                        }
                                      },
                                      color: ColorsAdoPet.yellowLogo),
                                ],
                              ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  registerPet() {
    registerPetBloc.add(
      CreatePetEvent(
        petName: _tPetName.text,
        description: _tDescription.text,
        type: _groupValue!,
      ),
    );
  }

  List<Widget> canSave() {
    final controllersEmpty = <Widget>[];
    if (_tPetName.text.isEmpty) {
      controllersEmpty.add(
        Padding(
          padding: const EdgeInsets.only(left: 200),
          child: Text(
            TextsAdoPet.namePet,
            style: TextStyleAdoPet.bodyBold16,
          ),
        ),
      );
    }
    if (_tDescription.text.isEmpty) {
      controllersEmpty.add(
        Padding(
          padding: const EdgeInsets.only(left: 200),
          child: Text(
            TextsAdoPet.description,
            style: TextStyleAdoPet.bodyBold16,
          ),
        ),
      );
      if (_groupValue == null) {
        controllersEmpty.add(
          Padding(
            padding: const EdgeInsets.only(left: 200),
            child: Text(
              TextsAdoPet.type + ' (Cachorro ou Gato)',
              style: TextStyleAdoPet.bodyBold16,
            ),
          ),
        );
      }
      if (editModePet && _groupValue == null) {
        controllersEmpty.add(
          Padding(
            padding: const EdgeInsets.only(left: 200),
            child: Text(
              TextsAdoPet.status,
              style: TextStyleAdoPet.bodyBold16,
            ),
          ),
        );
      }
    }

    return controllersEmpty;
  }

  _textEdit() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          TextsAdoPet.ops,
          style: TextStyleAdoPet.headingWhite,
        ),
        Text(
          TextsAdoPet.editPet,
          style: TextStyleAdoPet.headingWhite,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        )
      ],
    );
  }

  String convertStatusInNumber(String value) {
    if (value == TextsAdoPet.availableForAdoption) {
      return '0';
    } else if (value == TextsAdoPet.adopted) {
      return '1';
    } else {
      return '';
    }
  }

  String convertNumberInStatus(String value) {
    if (value == '0') {
      return TextsAdoPet.availableForAdoption;
    } else if (value == '1') {
      return TextsAdoPet.adopted;
    } else {
      return '';
    }
  }

  void editPet() {
    registerPetBloc.add(
      EditedPetEvent(
        pet: Pet(
          id: petAndUsers!.id,
          petName: _tPetName.text,
          type: _groupValue!,
          status: convertStatusInNumber(_groupValueStatus!),
          description: _tDescription.text,
          userId: widget.userId!,
        ),
      ),
    );
  }
}
