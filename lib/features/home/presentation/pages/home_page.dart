import 'package:adopet/core/usecases/usecase.dart';
import 'package:adopet/core/utils/nav.dart';
import 'package:adopet/core/values/colors_adopet.dart';
import 'package:adopet/core/values/images_adopet.dart';
import 'package:adopet/core/values/text_style_adopet.dart';
import 'package:adopet/core/values/texts_adopet.dart';
import 'package:adopet/core/widgets/button_geral.dart';
import 'package:adopet/features/home/presentation/bloc/home_bloc.dart';
import 'package:adopet/features/home/presentation/widget/container_type_pet.dart';
import 'package:adopet/features/pet/presentation/pages/list_pets_page.dart';
import 'package:adopet/features/pet/presentation/pages/pet_register_page.dart';
import 'package:adopet/features/user/domain/entities/user.dart';
import 'package:adopet/features/user/domain/usecases/log_out.dart';
import 'package:adopet/features/user/presentation/pages/user_register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeBloc homeBloc;
  final GlobalKey _menuState = GlobalKey();

  int? userId;
  User? user;

  @override
  void initState() {
    super.initState();

    homeBloc = HomeBloc(
      getCachedUser: sl(),
    )..add(CheckLoginEvent());
  }

  @override
  void dispose() {
    homeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsAdoPet.white,
      body: _body(),
    );
  }

  _body() {
    return SingleChildScrollView(
        child: Column(
      children: [_header(), _conteudo()],
    ));
  }

  _conteudo() {
    return Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              
              Row(
                children: [
                  Container(
                    color: ColorsAdoPet.header,
                    width: 260,
                    height: MediaQuery.of(context).size.height * .65,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .65,
                    child: Image.asset(
                      ImagesAdoPet.dogAndCat,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height * .65,
                      color: ColorsAdoPet.white,

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 12),
                            height: MediaQuery.of(context).size.height * .35,
                            width: 300,

                            child: Center(
                              child: Column(
                                children: [
                                  Image.asset(
                                    ImagesAdoPet.logoHorizontal,
                                    height: 175,
                                  ),
                                  Text(
                                    TextsAdoPet.findYourFriend,
                                    style: TextStyleAdoPet.titleBold25,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned.fill(
          child: Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * .50),
            child: Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ContainerTypePet(
                    widget: Image.asset(
                      ImagesAdoPet.cat,
                    ),
                    onTap: () => push(
                      context,
                      ListPetPage(
                        type: 'GATO',
                        userId: userId,
                        isAll: false,
                      ),
                    ),
                  ),
                  ContainerTypePet(
                    widget: Image.asset(
                      ImagesAdoPet.dog,
                    ),
                    onTap: () => push(
                      context,
                      ListPetPage(
                        type: 'CACHORRO',
                        userId: userId,
                        isAll: false,
                      ),
                    ),
                  ),
                  ContainerTypePet(
                    widget: Image.asset(
                      ImagesAdoPet.all,
                    ),
                    onTap: () => push(
                      context,
                      ListPetPage(
                        type: null,
                        userId: userId,
                        isAll: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  _header() {
    return SizedBox(
      height: 80,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Container(
            color: ColorsAdoPet.white,
          ),
          ClipPath(
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: ColorsAdoPet.header,
            ),
            clipper: CustomClipPath(),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 15, top: 12),
              child: BlocBuilder(
                bloc: homeBloc,
                builder: (context, state) {
                  if (state is Loaded) {
                    userId = state.user.id;
                    user = state.user;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          TextsAdoPet.hello,
                          style: TextStyleAdoPet.headingGrey,
                        ),
                        Text(
                          state.user.name,
                          style: TextStyleAdoPet.headingGrey,
                        ),
                        _popupMenu(),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .05,
                        ),
                        Text(
                          TextsAdoPet.rescuedPet,
                          style: TextStyleAdoPet.headingGrey,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        ButtonGeral(
                            icon: false,
                            text: TextsAdoPet.registerPet,
                            width: 100,
                            height: 40,
                            fontSize: 13,
                            onPressed: () => push(
                                context,
                                PetRegisterPage(
                                  userId: state.user.id,
                                )),
                            color: ColorsAdoPet.blueLogo),
                      ],
                    );
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        TextsAdoPet.rescuedPet,
                        style: TextStyleAdoPet.headingGrey,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      ButtonGeral(
                          icon: false,
                          text: TextsAdoPet.registerPet,
                          width: 100,
                          height: 40,
                          fontSize: 13,
                          onPressed: () => push(
                                context,
                                const UserRegisterPage(),
                              ),
                          color: ColorsAdoPet.blueLogo),
                    ],
                  );
                },
              ),
            ),
          ),
          //
        ],
      ),
    );
  }

  PopupMenuButton<String> _popupMenu() {
    return PopupMenuButton<String>(
      offset: const Offset(0, 30),
      key: _menuState,
      padding: EdgeInsets.zero,
      onSelected: (value) {
        _onClickOptionMenu(context, value);
      },
      child: const Icon(
        Icons.expand_more_outlined,
        size: 24,
        color: ColorsAdoPet.yellowLogo,
      ),
      itemBuilder: (BuildContext context) => _getActions(),
    );
  }

  List<PopupMenuItem<String>> _getActions() {
    return <PopupMenuItem<String>>[
      // PopupMenuItem<String>(
      //   value: 'editar_perfil',
      //   child: Row(
      //     children: [
      //       const Icon(
      //         Icons.account_circle_outlined,
      //         color: ColorsAdoPet.blueLogo,
      //       ),
      //       const SizedBox(
      //         width: 5,
      //       ),
      //       Text(TextsAdoPet.editUser, style: TextStyleAdoPet.bodyBold),
      //     ],
      //   ),
      // ),
      PopupMenuItem<String>(
        value: 'logout',
        child: Row(
          children: [
            const Icon(Icons.cancel_outlined),
            const SizedBox(
              width: 5,
            ),
            Text(TextsAdoPet.logout, style: TextStyleAdoPet.bodyBold),
          ],
        ),
      ),
    ];
  }

  void _onClickOptionMenu(context, String value) {
    if ('logout' == value) {
      LogOut(
        userRepository: sl(),
      )
          .call(
            NoParams(),
          )
          .then(
            (value) => push(
              context,
              const HomePage(),
              replace: true,
            ),
          );
    } else if ('alterar_senha' == value) {
      setState(() {
        // widget.pageController.jumpToPage(4);
      });
    } else {}
  }
}

class CustomClipPath extends CustomClipper<Path> {
  var radius = 10.0;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 200);
    path.lineTo(2000, 400);
    path.lineTo(260, 0);
    path.lineTo(30, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
