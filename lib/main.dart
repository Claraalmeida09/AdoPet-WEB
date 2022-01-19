import 'package:adopet/features/login/presentation/pages/login_page.dart';
import 'package:adopet/features/home/presentation/pages/home_page.dart';
import 'package:adopet/features/user/presentation/pages/user_register_page.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: const UserRegisterPage(),
        home: const HomePage(),
      ),
    );
  }
}
