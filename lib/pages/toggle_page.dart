import 'package:flutter/material.dart';
import 'package:todo/pages/favoritos_page.dart';
import 'package:todo/pages/home_page.dart';

class TogglePage extends StatefulWidget {
  const TogglePage({Key? key}) : super(key: key);

  @override
  _TogglePageState createState() => _TogglePageState();
}

class _TogglePageState extends State<TogglePage> {
  int _paginaAtual = 0;
  late PageController _pc;

  @override
  void initState() {
    _pc = PageController(initialPage: _paginaAtual);
    super.initState();
  }

  bool? temaBar;

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pc,
        children: const [
          //páginas que serão exibidas no menu inferior.
          HomePage(),
          FavoritosPage(),
        ],
        //Quando houver mudança de página chame o setState para atualizar a pagina e os icones.
        onPageChanged: (int pagina) {
          setState(() {
            _paginaAtual = pagina;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: temaBar! ? Colors.black54 : Colors.white,
        elevation: temaBar! ? 0 : 20,
        currentIndex: _paginaAtual,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Todas'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favoritas'),
        ],
        onTap: (int pagina) {
          _pc.animateToPage(pagina,
              duration: const Duration(milliseconds: 200), curve: Curves.ease);
        },
      ),
    );
  }
}
