import 'package:adopet/core/utils/nav.dart';
import 'package:adopet/core/utils/validators.dart';
import 'package:adopet/core/values/colors_adopet.dart';
import 'package:adopet/core/values/images_adopet.dart';
import 'package:adopet/core/values/text_style_adopet.dart';
import 'package:adopet/core/values/texts_adopet.dart';
import 'package:adopet/core/widgets/adopet_toast.dart';
import 'package:adopet/core/widgets/button_geral.dart';
import 'package:adopet/core/widgets/loading_widget.dart';
import 'package:adopet/features/login/domain/usecases/authentication.dart';
import 'package:adopet/features/login/presentation/bloc/login_bloc.dart';
import 'package:adopet/features/login/widget/form_login.dart';
import 'package:adopet/features/pet/presentation/pages/pet_register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginBloc _loginBloc;

  final _formKey = GlobalKey<FormState>();
  final _tUsername = TextEditingController();
  final _tPassword = TextEditingController();
  Color color = ColorsAdoPet.yellowLogo;

  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc(
      authentication: sl<Authentication>(),
      getUser: sl(),
    );
  }

  @override
  void dispose() {
    _loginBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      listener: _handleStateUpdate,
      bloc: _loginBloc,
      child: _body(),
    );
  }

  Future<void> _handleStateUpdate(
      BuildContext context, LoginState state) async {
    if (state is Loading) {
      AdoPetToast.showToastWithWidgetAndMessage(
        context,
        TextsAdoPet.defaultLoadingMessage,
        const LoadingWidget(),
      );
    }

    if (state is Error) {
      AdoPetToast.showToastWithMessageAndIcon(
          context, state.message, Icons.error,
          color: ColorsAdoPet.obrigatory, duration: 5, width: 300);
    }

    if (state is Loaded) {
      await Future.delayed(const Duration(milliseconds: 1750));

      push(
        context,
        PetRegisterPage(
          userId: state.user?.id,
        ),
      );
    }
  }

  Widget _body() {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              ImagesAdoPet.planoDeFundo,
              fit: BoxFit.cover,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                color: Colors.white.withOpacity(.8),
                width: MediaQuery.of(context).size.width * .5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .03,
                    ),
                    Image.asset(ImagesAdoPet.logoAdoPet),
                    Text(
                      TextsAdoPet.responsibleAdoption,
                      style: TextStyleAdoPet.heading,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .15,
                    ),
                    Form(
                      autovalidateMode: AutovalidateMode.disabled,
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * .3,
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                  color: color,
                                  width: 4.0,
                                ),
                              ),
                            ),
                            child: FormLogin(
                              validator: Validators.usernameValidator,
                              obscureText: false,
                              controller: _tUsername,
                              icon: Icons.perm_identity_outlined,
                              hintText: TextsAdoPet.username,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * .3,
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                  color: color,
                                  width: 4.0,
                                ),
                              ),
                            ),
                            child: FormLogin(
                              validator: Validators.passwordValidator,
                              obscureText: true,
                              maxLines: 1,
                              controller: _tPassword,
                              icon: Icons.lock,
                              hintText: TextsAdoPet.password,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 150),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ButtonGeral(
                                  text: TextsAdoPet.enter,
                                  color: ColorsAdoPet.yellowLogo,
                                  width: 84,
                                  height: 34,
                                  fontSize: 14,
                                  onPressed: () => _onPressedLogin(),
                                  icon: false,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .06,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: const [
                        Text(
                          TextsAdoPet.copy,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  _onPressedLogin() {
    if (_formKey.currentState!.validate()) {
      _loginBloc.add(
        UserAuthenticationEvent(
          username: _tUsername.text,
          password: _tPassword.text,
        ),
      );
    }
  }
}
