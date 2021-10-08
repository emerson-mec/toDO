import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/tarefa_model.dart';
import 'package:todo/repositories/favoritos_repository.dart';

import 'detalhes_page.dart';

class FavoritosPage extends StatefulWidget {
  const FavoritosPage({Key? key}) : super(key: key);

  @override
  _FavoritosPageState createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage> {
  // late FavoritosProvider favoritosRaw;

  @override
  Widget build(BuildContext context) {
    List<TarefaMODEL> favoritosRaw =
        Provider.of<FavoritosProvider>(context).favoritosList;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: favoritosRaw.length,
        itemBuilder: (context, i) {
          return ListTile(
            title: Text('${favoritosRaw[i].nome}',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('${favoritosRaw[i].descricao}',
                maxLines: 2, overflow: TextOverflow.fade),
            trailing: GestureDetector(
              child: const Icon(Icons.star, color: Colors.amber,),
              onTap: () {
                Provider.of<FavoritosProvider>(context,listen: false)
                    .removerFavoritos(favoritosRaw[i]);
              },
            ),
            onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context) =>DetalhesPage(tarefa: favoritosRaw[i]))),
            // leading: selecionadas.contains(tarefas[i])
            //     ? const CircleAvatar(child: Icon(Icons.check))
            //     : GestureDetector(
            //         onTap: () => Provider.of<TarefasPROVIDER>(context,
            //                 listen: false)
            //             .remover(tarefas[i]),
            //         child: const CircleAvatar(
            //             backgroundColor: Colors.red,
            //             child: Icon(Icons.delete, color: Colors.white))),
            //selected: selecionadas.contains(tarefas[i]),
            // selectedTileColor: Colors.blue[100],
            // onLongPress: () => favoritos(selecionadas, tarefas, i),
          );
        },
      ),
    );
  }
}
