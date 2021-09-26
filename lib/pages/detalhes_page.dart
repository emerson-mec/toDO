import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/tarefa_model.dart';

class DetalhesPage extends StatefulWidget {
  final TarefaMODEL? tarefa;

  const DetalhesPage({Key? key, this.tarefa}) : super(key: key);

  @override
  _DetalhesPageState createState() => _DetalhesPageState();
}

class _DetalhesPageState extends State<DetalhesPage> {
  Widget imagem() {
    return SizedBox(
      child: widget.tarefa!.imagem != null 
          ? Image.network('${widget.tarefa!.imagem}')
          : Image.network(
              'https://cdn-icons-png.flaticon.com/512/1695/1695213.png'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.tarefa!.nome.toString())),
      //
      body: SingleChildScrollView(
        child: Column(
          children: [
            imagem(),
            const Text(
              'DECRIÇÃO:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Feito: ${widget.tarefa!.feito}',
              style: const TextStyle(color: Colors.green),
            ),
            Text(
              '${widget.tarefa!.descricao}',
              style: const TextStyle(fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
    );
  }
}
