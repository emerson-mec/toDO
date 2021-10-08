import 'package:flutter/cupertino.dart';
import 'package:todo/models/tarefa_model.dart';

class FavoritosProvider extends ChangeNotifier {
  final List<TarefaMODEL> _favoritosList = [
    // TarefaMODEL(
    //   imagem:
    //       'https://img.elo7.com.br/product/zoom/FBCE34/adesivo-paisagem-praia-decorando-com-adesivos.jpg',
    //   descricao: 'Aqui uma descrição',
    //   favoritos: false,
    //   feito: false,
    //   nome: 'Estudars',
    // ),
  ];

  List<TarefaMODEL> get favoritosList => _favoritosList;

  addFavoritos(List<TarefaMODEL> tarefasFavoritas) {
    for (TarefaMODEL tarefa in tarefasFavoritas) {
      if (!_favoritosList.contains(tarefa)) _favoritosList.add(tarefa);
    }
    notifyListeners();
  }
  
   removerFavoritos(TarefaMODEL tarefa) {
    _favoritosList.remove(tarefa);
    notifyListeners();
  }
}
