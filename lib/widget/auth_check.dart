import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/pages/home_page.dart';
import 'package:todo/pages/login_page.dart';
import 'package:todo/services/auth_service.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  _AuthCheckState createState() => _AuthCheckState();
}

//REDIRECIONE USUÁRIO LOGADO E DESLOGADO PARA ALGUMA PAGE
class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);

    if (auth.isLoading) {
      return loading();
    } else if (auth.usuario == null) {
      return const LoginPage();
    } else {
      return const HomePage();
    }
  }

  loading() {
    return const Scaffold(
      body: Center(child: LinearProgressIndicator()),
    );
  }
}
