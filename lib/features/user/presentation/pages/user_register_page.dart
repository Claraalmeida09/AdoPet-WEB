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
import 'package:adopet/features/login/presentation/pages/login_page.dart';
import 'package:adopet/features/user/domain/entities/user.dart';
import 'package:adopet/features/user/presentation/bloc/user_bloc.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';

class UserRegisterPage extends StatefulWidget {
  const UserRegisterPage({Key? key}) : super(key: key);

  @override
  State<UserRegisterPage> createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends State<UserRegisterPage> {
  late UserBloc registerUserBloc;

  final _formKey = GlobalKey<FormState>();
  final _tUsername = TextEditingController();
  final _tPassword = TextEditingController();
  final _tName = TextEditingController();
  final _tEmail = TextEditingController();
  final _tPhone = TextEditingController();

  @override
  void initState() {
    super.initState();

    registerUserBloc = UserBloc(
      createUser: sl(),
    );
  }

  @override
  void dispose() {
    registerUserBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      listener: _handleStateUpdate,
      bloc: registerUserBloc,
      child: _body(context),
    );
  }

  Future<void> _handleStateUpdate(BuildContext context, UserState state) async {
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
        TextsAdoPet.successOnRegister,
        const SuccessWidget(),
        onDismiss: () => push(
          context,
          const LoginPage(),
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
      body: Row(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width * .4,
            decoration: const BoxDecoration(
              color: ColorsAdoPet.blueLogo,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .05,
                ),
                Image.asset(
                  ImagesAdoPet.logoNome,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 150,
                      child: Text(
                        TextsAdoPet.welcome,
                        style: TextStyleAdoPet.titleBoldWhite,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .03,
                    ),
                    SizedBox(
                      width: 200,
                      child: Text(
                        TextsAdoPet.accessYourAccount,
                        style: TextStyleAdoPet.headingWhite,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .05,
                    ),
                    ButtonGeral(
                        icon: false,
                        text: TextsAdoPet.enter,
                        borderColor: ColorsAdoPet.white,
                        width: MediaQuery.of(context).size.width * .1,
                        height: 40,
                        fontSize: 15,
                        onPressed: () => push(
                              context,
                              const LoginPage(),
                            ),
                        color: Colors.transparent)
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .15,
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width * .6,
            color: ColorsAdoPet.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          TextsAdoPet.createYourAccount,
                          style: TextStyleAdoPet.titleBold25,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Image.asset(
                          ImagesAdoPet.logoImage,
                          width: 60,
                          height: 60,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      TextsAdoPet.fillData,
                      style: TextStyleAdoPet.headingGrey,
                    ),
                  ],
                ),
                Form(
                  key: _formKey,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * .60,
                    width: MediaQuery.of(context).size.width * .3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ColumnForm(
                          style: TextStyleAdoPet.bodyBold,
                          text: TextsAdoPet.username,
                          obrigatory: TextsAdoPet.asterisk,
                          widget: FormRegister(
                            maxLines: 1,
                            hintColor: ColorsAdoPet.hintText,
                            controller: _tUsername,
                            obscureText: false,
                            width: MediaQuery.of(context).size.width * .20,
                            enabled: true,
                            hintText: TextsAdoPet.username,
                          ),
                        ),
                        ColumnForm(
                          style: TextStyleAdoPet.bodyBold,
                          text: TextsAdoPet.password,
                          obrigatory: TextsAdoPet.asterisk,
                          widget: FormRegister(
                            maxLines: 1,
                            hintColor: ColorsAdoPet.hintText,
                            controller: _tPassword,
                            obscureText: true,
                            width: MediaQuery.of(context).size.width * .20,
                            enabled: true,
                            hintText: TextsAdoPet.hintPassword,
                          ),
                        ),
                        ColumnForm(
                          style: TextStyleAdoPet.bodyBold,
                          text: TextsAdoPet.name,
                          obrigatory: TextsAdoPet.asterisk,
                          widget: FormRegister(
                            maxLines: 1,
                            hintColor: ColorsAdoPet.hintText,
                            controller: _tName,
                            obscureText: false,
                            width: MediaQuery.of(context).size.width * .20,
                            enabled: true,
                            hintText: TextsAdoPet.hintName,
                          ),
                        ),
                        ColumnForm(
                          style: TextStyleAdoPet.bodyBold,
                          text: TextsAdoPet.email,
                          obrigatory: TextsAdoPet.asterisk,
                          widget: FormRegister(
                            maxLines: 1,
                            hintColor: ColorsAdoPet.hintText,
                            controller: _tEmail,
                            obscureText: false,
                            width: MediaQuery.of(context).size.width * .20,
                            enabled: true,
                            hintText: TextsAdoPet.hintEmail,
                          ),
                        ),
                        ColumnForm(
                          style: TextStyleAdoPet.bodyBold,
                          text: TextsAdoPet.phone,
                          obrigatory: TextsAdoPet.asterisk,
                          widget: FormRegister(
                            maxLines: 1,
                            hintColor: ColorsAdoPet.hintText,
                            controller: _tPhone,
                            obscureText: false,
                            width: MediaQuery.of(context).size.width * .20,
                            enabled: true,
                            hintText: TextsAdoPet.hintCellFormater,
                            formatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              TelefoneInputFormatter(),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ButtonGeral(
                                icon: false,
                                text: TextsAdoPet.registerUser,
                                width: 100,
                                height: 40,
                                fontSize: 14,
                                //onPressed: () => createUser(),
                                onPressed: () async {
                                  final canSaveList = canSave();
                                  if (canSaveList.isEmpty) {
                                    createUser();
                                  } else {
                                    await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ValidatorDialog(
                                          canSaveList: canSaveList,
                                          title: TextsAdoPet.errorRegister,
                                          subtitle: TextsAdoPet.subtitleError,
                                          text: TextsAdoPet.please,
                                        );
                                      },
                                    );
                                  }
                                },
                                color: ColorsAdoPet.blueLogo),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  List<Widget> canSave() {
    final controllersEmpty = <Widget>[];
    if (_tUsername.text.isEmpty) {
      controllersEmpty.add(
        Padding(
          padding: const EdgeInsets.only(left: 200),
          child: Text(
            TextsAdoPet.username,
            style: TextStyleAdoPet.bodyBold16,
          ),
        ),
      );
    }
    if (_tName.text.isEmpty) {
      controllersEmpty.add(
        Padding(
          padding: const EdgeInsets.only(left: 200),
          child: Text(
            TextsAdoPet.name,
            style: TextStyleAdoPet.bodyBold16,
          ),
        ),
      );
    }
    if (_tPassword.text.isEmpty) {
      controllersEmpty.add(
        Padding(
          padding: const EdgeInsets.only(left: 200),
          child: Text(
            TextsAdoPet.password,
            style: TextStyleAdoPet.bodyBold16,
          ),
        ),
      );
    }
    if (_tEmail.text.isEmpty) {
      controllersEmpty.add(
        Padding(
          padding: const EdgeInsets.only(left: 200),
          child: Text(
            TextsAdoPet.email,
            style: TextStyleAdoPet.bodyBold16,
          ),
        ),
      );
    }
    if (_tPhone.text.isEmpty) {
      controllersEmpty.add(
        Padding(
          padding: const EdgeInsets.only(left: 200),
          child: Text(
            TextsAdoPet.phone,
            style: TextStyleAdoPet.bodyBold16,
          ),
        ),
      );
    }
    return controllersEmpty;
  }

  void createUser() {
    registerUserBloc.add(
      CreateUserEvent(
        user: User(
          username: _tUsername.text,
          name: _tName.text,
          email: _tEmail.text,
          password: _tPassword.text,
          phone: _tPhone.text,
        ),
      ),
    );
  }
}
