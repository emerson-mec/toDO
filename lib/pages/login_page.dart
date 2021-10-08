import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailEC = TextEditingController();
  final TextEditingController _senhaEC = TextEditingController();
  final TextEditingController _nomeEC = TextEditingController();

  bool _isLogin = true;
  bool _isloading = false;

  valide() {
    if (_formKey.currentState!.validate()) {
      if (_isLogin) {
        login();
      } else {
        registrar();
      }
    }
  }

  login() async {
    setState(() => _isloading = true);
    try {
      await Provider.of<AuthService>(context, listen: false)
          .login(_emailEC.text, _senhaEC.text);
    } on AuthException catch (e) {
      setState(() => _isloading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  registrar() async {
    setState(() => _isloading = true);
    try {
      await Provider.of<AuthService>(context, listen: false).registrar(_emailEC.text, _senhaEC.text, _nomeEC.text);
    } on AuthException catch (e) {
      setState(() => _isloading = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _isLogin
                        ? const Text("BEM VINDO!")
                        : const Text("CRIAR CONTA"),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'E-mail'),
                      controller: _emailEC,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Informe um e-mail';
                        } else if (!value.contains('@')) {
                          return 'Informe um e-mail válido';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Senha'),
                      controller: _senhaEC,
                      obscureText: true,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Informe uma senha';
                        } else if (value.length < 6) {
                          return 'A senha deve ter pelo menos 6 caracteres';
                        }
                        return null;
                      },
                    ),
                    if (!_isLogin)
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Nome'),
                        controller: _nomeEC,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Informe seu nome';
                          } else if (value.length < 3) {
                            return 'Nome muito pequeno';
                          }
                          return null;
                        },
                      ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => valide(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _isLogin
                              ? _isloading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white)
                                  : const Text('ENTRAR')
                              : _isloading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white)
                                  : const Text('REGISTRAR'),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () => setState(() => _isLogin = !_isLogin),
                      child: _isLogin
                          ? const Text('Criar conta')
                          : const Text('Já tenho uma conta'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
