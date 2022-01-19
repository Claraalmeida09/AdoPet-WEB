import 'package:adopet/core/utils/nav.dart';
import 'package:adopet/core/values/colors_adopet.dart';
import 'package:adopet/core/values/images_adopet.dart';
import 'package:adopet/core/values/text_style_adopet.dart';
import 'package:adopet/core/values/texts_adopet.dart';
import 'package:adopet/core/widgets/adopet_toast.dart';
import 'package:adopet/core/widgets/button_actions.dart';
import 'package:adopet/core/widgets/button_geral.dart';
import 'package:adopet/core/widgets/loading_widget.dart';
import 'package:adopet/features/home/presentation/pages/home_page.dart';
import 'package:adopet/features/pet/domain/entities/pet_and_users.dart';
import 'package:adopet/features/pet/presentation/bloc/pet_bloc.dart';
import 'package:adopet/features/pet/presentation/pages/pet_register_page.dart';
import 'package:adopet/features/pet/presentation/widget/radio_widget.dart';
import 'package:adopet/features/user/domain/entities/user.dart';
import 'package:adopet/features/user/presentation/pages/user_register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../injection_container.dart';

class ListPetPage extends StatefulWidget {
  const ListPetPage(
      {Key? key, this.type, this.userId, required this.isAll, this.user})
      : super(key: key);
  final String? type;
  final int? userId;
  final bool isAll;
  final User? user;

  @override
  _ListPetPageState createState() => _ListPetPageState();
}

class _ListPetPageState extends State<ListPetPage> {
  String? _groupValue = 'Todos';
  final ScrollController _slidingInYourDMs = ScrollController();
  late PetBloc _petBloc;
  final _petsAndUsers = <PetAndUsers>[];

  ValueChanged<String?> _valueChangedHandler(String? status) {
    if (status == null) {
      return (value) => setState(() {
            _petBloc.add(
              ListPetsAndUsersEvent(type: widget.type),
            );
            _groupValue = value!;
          });
    }
    return (value) => setState(() {
          _petBloc.add(
            ListPetsAndUsersEvent(type: widget.type, status: status),
          );
          _groupValue = value!;
        });
  }

  @override
  void initState() {
    super.initState();
    _petBloc = PetBloc(
      listPetsAndUsers: sl(),
      deletePet: sl(),
    )..add(
        ListPetsAndUsersEvent(type: widget.type),
      );
  }

  @override
  void dispose() {
    _petBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsAdoPet.blueLogo,
      body: Scrollbar(
        isAlwaysShown: true,
        showTrackOnHover: true,
        controller: _slidingInYourDMs,
        child: SingleChildScrollView(
          controller: _slidingInYourDMs,
          child: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Column(
              children: [
                mensage(),
                filterAndButton(),
                const SizedBox(
                  height: 15,
                ),
                tablePets(),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  TextsAdoPet.copy,
                  style: TextStyleAdoPet.bodyBoldWhite,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget filterAndButton() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Text(
              TextsAdoPet.filterStatus,
              style: TextStyleAdoPet.headingWhite,
            ),
            Row(
              children: [
                MyRadioOption<String>(
                  value: 'Disponível para adoção',
                  groupValue: _groupValue,
                  onChanged: _valueChangedHandler('0'),
                  label: '0',
                  fontSize: 15,
                  widthContainer: 200,
                ),
                MyRadioOption<String>(
                  value: 'Adotado',
                  groupValue: _groupValue,
                  onChanged: _valueChangedHandler('1'),
                  label: '1',
                  fontSize: 15,
                  widthContainer: 200,
                ),
                MyRadioOption<String>(
                  value: 'Todos',
                  groupValue: _groupValue,
                  onChanged: _valueChangedHandler(null),
                  label: '1',
                  fontSize: 15,
                  widthContainer: 200,
                ),
              ],
            ),
          ],
        ),
        widget.userId != null
            ? ButtonGeral(
                icon: true,
                iconAdd: Icons.add,
                text: TextsAdoPet.registerNewPet,
                width: 200,
                height: 40,
                fontSize: 15,
                color: ColorsAdoPet.button,
                onPressed: () {
                  push(
                    context,
                    PetRegisterPage(
                      userId: widget.userId,
                    ),
                  );
                },
              )
            : ButtonGeral(
                icon: true,
                iconAdd: Icons.add,
                text: TextsAdoPet.registerPet,
                width: 200,
                height: 40,
                fontSize: 13,
                onPressed: () => push(
                      context,
                      const UserRegisterPage(),
                    ),
                color: ColorsAdoPet.button),
      ],
    );
  }

  Widget tablePets() {
    return BlocConsumer(
      bloc: _petBloc,
      builder: (context, state) {
        if (state is Loading) {
          AdoPetToast.showToastWithWidgetAndMessage(
            context,
            TextsAdoPet.defaultLoadingMessage,
            const LoadingWidget(),
          );
        } else if (state is Error) {
          AdoPetToast.showToastWithMessageAndIcon(
              context, state.message, Icons.error,
              color: ColorsAdoPet.obrigatory, duration: 5, width: 300);
        } else if (state is Loaded) {
          _petsAndUsers.clear();
          _petsAndUsers.addAll(state.list);
        }
        return SizedBox(
          width: MediaQuery.of(context).size.width * .9,
          child: DataTable(
            headingRowColor: MaterialStateColor.resolveWith(
                (states) => ColorsAdoPet.yellowLogo),
            columns: widget.isAll ? colimnsWithType() : columns(),
            // rows: [_dataRow(petAndUsers: )],
            rows: widget.isAll
                ? List.generate(
                    _petsAndUsers.length,
                    (index) => _dataRowWithType(
                      _petsAndUsers[index],
                    ),
                  )
                : List.generate(
                    _petsAndUsers.length,
                    (index) => _dataRow(
                      _petsAndUsers[index],
                    ),
                  ),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {
        if (state is Deleted) {
          String? status;

          if (_groupValue == 'Disponível para adoção') {
            status = '0';
          } else if (_groupValue == 'Adotado') {
            status = '1';
          }

          _petBloc
              .add(ListPetsAndUsersEvent(type: widget.type, status: status));
        }
      },
    );
  }

  List<DataColumn> columns() {
    return [
      DataColumn(
        label: Text(
          TextsAdoPet.namePet,
          style: TextStyleAdoPet.bodyBoldWhite16,
        ),
      ),
      DataColumn(
        label: Text(
          TextsAdoPet.description,
          style: TextStyleAdoPet.bodyBoldWhite16,
        ),
      ),
      DataColumn(
        label: Text(
          TextsAdoPet.status,
          style: TextStyleAdoPet.bodyBoldWhite16,
        ),
      ),
      DataColumn(
        label: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              TextsAdoPet.responsible,
              style: TextStyleAdoPet.bodyBoldWhite16,
            ),
            Text(
              TextsAdoPet.temporaryHome,
              style: TextStyleAdoPet.bodyBoldWhite16,
            ),
          ],
        ),
      ),
      DataColumn(
        label: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              TextsAdoPet.contactPhone,
              style: TextStyleAdoPet.bodyBoldWhite16,
            ),
            Text(
              TextsAdoPet.contact,
              style: TextStyleAdoPet.bodyBoldWhite16,
            ),
          ],
        ),
      ),
      DataColumn(
        label: Text(
          TextsAdoPet.email,
          style: TextStyleAdoPet.bodyBoldWhite16,
        ),
      ),
      DataColumn(
        label: Text(
          TextsAdoPet.actions,
          style: TextStyleAdoPet.bodyBoldWhite16,
        ),
      ),
    ];
  }

  List<DataColumn> colimnsWithType() {
    return [
      DataColumn(
        label: Text(
          TextsAdoPet.namePet,
          style: TextStyleAdoPet.bodyBoldWhite16,
        ),
      ),
      DataColumn(
        label: Text(
          TextsAdoPet.type,
          style: TextStyleAdoPet.bodyBoldWhite16,
        ),
      ),
      DataColumn(
        label: Text(
          TextsAdoPet.description,
          style: TextStyleAdoPet.bodyBoldWhite16,
        ),
      ),
      DataColumn(
        label: Text(
          TextsAdoPet.status,
          style: TextStyleAdoPet.bodyBoldWhite16,
        ),
      ),
      DataColumn(
        label: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              TextsAdoPet.responsible,
              style: TextStyleAdoPet.bodyBoldWhite16,
            ),
            Text(
              TextsAdoPet.temporaryHome,
              style: TextStyleAdoPet.bodyBoldWhite16,
            ),
          ],
        ),
      ),
      DataColumn(
        label: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              TextsAdoPet.contactPhone,
              style: TextStyleAdoPet.bodyBoldWhite16,
            ),
            Text(
              TextsAdoPet.contact,
              style: TextStyleAdoPet.bodyBoldWhite16,
            ),
          ],
        ),
      ),
      DataColumn(
        label: Text(
          TextsAdoPet.email,
          style: TextStyleAdoPet.bodyBoldWhite16,
        ),
      ),
      DataColumn(
        label: Text(
          TextsAdoPet.actions,
          style: TextStyleAdoPet.bodyBoldWhite16,
        ),
      ),
    ];
  }

  DataRow _dataRow(PetAndUsers petAndUsers) {
    return DataRow(
      color: MaterialStateColor.resolveWith(
          (states) => ColorsAdoPet.white.withOpacity(.5)),
      cells: [
        DataCell(
          Text(petAndUsers.petName),
        ),
        DataCell(
          SizedBox(width: 150, child: Text(petAndUsers.description ?? '')),
        ),
        DataCell(
          Text(convertNumberInStatus(petAndUsers.status)),
        ),
        DataCell(
          Text(petAndUsers.name),
        ),
        DataCell(
          Text(petAndUsers.phone),
        ),
        DataCell(
          Text(petAndUsers.email),
        ),
        if (petAndUsers.userId == widget.userId)
          DataCell(
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonsActions(
                    icon: FontAwesomeIcons.edit,
                    color: Colors.blue,
                    onPressed: () {
                      push(
                        context,
                        PetRegisterPage(
                          petAndUsers: petAndUsers,
                          userId: widget.userId,
                        ),
                      );
                    },
                    size: 16),
                const SizedBox(
                  width: 12,
                ),
                ButtonsActions(
                    icon: Icons.delete,
                    color: Colors.red,
                    onPressed: () => deletePet(petAndUsers.id!),
                    size: 16),
              ],
            ),
          )
        else
          const DataCell(
            Icon(
              Icons.do_disturb_alt_outlined,
              color: ColorsAdoPet.obrigatory,
            ),
          )
      ],
    );
  }

  DataRow _dataRowWithType(PetAndUsers petAndUsers) {
    return DataRow(
      color: MaterialStateColor.resolveWith(
          (states) => ColorsAdoPet.white.withOpacity(.5)),
      cells: [
        DataCell(
          Text(petAndUsers.petName),
        ),
        DataCell(
          Text(petAndUsers.type),
        ),
        DataCell(
          SizedBox(width: 100, child: Text(petAndUsers.description ?? '')),
        ),
        DataCell(
          Text(convertNumberInStatus(petAndUsers.status)),
        ),
        DataCell(
          Text(petAndUsers.name),
        ),
        DataCell(
          Text(petAndUsers.phone),
        ),
        DataCell(
          Text(petAndUsers.email),
        ),
        if (petAndUsers.userId == widget.userId)
          DataCell(
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonsActions(
                    icon: FontAwesomeIcons.edit,
                    color: Colors.blue,
                    onPressed: () {
                      push(
                        context,
                        PetRegisterPage(
                          petAndUsers: petAndUsers,
                          userId: widget.userId,
                        ),
                      );
                    },
                    size: 16),
                const SizedBox(
                  width: 12,
                ),
                ButtonsActions(
                    icon: Icons.delete,
                    color: Colors.red,
                    onPressed: () => deletePet(petAndUsers.id!),
                    size: 16),
              ],
            ),
          )
        else
          const DataCell(
            Icon(
              Icons.do_disturb_alt_outlined,
              color: ColorsAdoPet.obrigatory,
            ),
          )
      ],
    );
  }

  mensage() {
    return SizedBox(
        width: MediaQuery.of(context).size.width * .9,
        height: MediaQuery.of(context).size.width * .1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () => push(context, const HomePage()),
              icon: const Icon(
                Icons.arrow_back_outlined,
                color: ColorsAdoPet.white,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  TextsAdoPet.mensage,
                  style: TextStyleAdoPet.headingWhite,
                ),
                if (widget.type == 'GATO')
                  Row(
                    children: [
                      Text(
                        TextsAdoPet.mensageCat,
                        style: TextStyleAdoPet.headingWhite,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      const Icon(
                        Icons.pets_outlined,
                        color: ColorsAdoPet.white,
                      ),
                    ],
                  )
                else if (widget.type == 'CACHORRO')
                  Row(
                    children: [
                      Text(
                        TextsAdoPet.mensageDog,
                        style: TextStyleAdoPet.headingWhite,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      const Icon(
                        Icons.pets_outlined,
                        color: ColorsAdoPet.white,
                      ),
                    ],
                  )
              ],
            ),
            Image.asset(ImagesAdoPet.logoAdoPetYellow),
          ],
        ));
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

  deletePet(int petId) {
    _petBloc.add(DeletedPetEvent(id: petId));
  }
}
