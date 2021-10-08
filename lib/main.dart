import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/configs/app_settings.dart';
import 'package:todo/constants/rotas.dart';
import 'package:todo/pages/adicionar_page.dart';
import 'package:todo/pages/detalhes_page.dart';
import 'package:todo/pages/editar_page.dart';
import 'package:todo/pages/favoritos_page.dart';
import 'package:todo/pages/home_page.dart';
import 'package:todo/pages/toggle_page.dart';
import 'package:todo/repositories/favoritos_repository.dart';
import 'package:todo/repositories/tarefas_repository.dart';
import 'package:todo/services/auth_service.dart';
import 'package:todo/widget/auth_check.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => TarefasPROVIDER()),
        ChangeNotifierProvider(create: (_) => FavoritosProvider()),
        ChangeNotifierProvider(create: (_) => AppSettings()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: AppRoutes.AUTH_CHECK_PAGE,
        routes: {
          AppRoutes.AUTH_CHECK_PAGE: (context) => const AuthCheck(),
          AppRoutes.TOGGLE_PAGE: (context) => const TogglePage(),
          AppRoutes.ADICIONAR_TAREFA_PAGE: (context) => const AdicionarPage(),
          AppRoutes.HOME_PAGE: (context) => const HomePage(),
          AppRoutes.DETALHES_PAGE: (context) => const DetalhesPage(),
          AppRoutes.FAVORITOS_PAGE: (context) => const FavoritosPage(),
          AppRoutes.EDITAR_PAGE: (context) => const EditarPage(),
        },
      ),
    );
  }
}
