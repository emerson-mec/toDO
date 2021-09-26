import 'package:flutter/cupertino.dart';
import 'package:todo/models/tarefa_model.dart';

class TarefasPROVIDER extends ChangeNotifier {
  final List<TarefaMODEL> _tarefas = <TarefaMODEL>[
    TarefaMODEL(
      imagem: 'https://img.elo7.com.br/product/zoom/FBCE34/adesivo-paisagem-praia-decorando-com-adesivos.jpg',
      descricao: 'Aqui uma descrição',
      feito: false,
      nome: 'Estudar',
    ),
  ];

  get tarefas => _tarefas;

  adicionar(TarefaMODEL tarefa) {
    _tarefas.add(tarefa);
    notifyListeners();
  }

  remover(TarefaMODEL tarefa) {
    _tarefas.remove(tarefa);
    notifyListeners();
  }

  isFeito(TarefaMODEL tarefa) {
    tarefa.feito = !tarefa.feito;
    notifyListeners();
  }
}
