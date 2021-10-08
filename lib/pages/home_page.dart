import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/constants/rotas.dart';
import 'package:todo/models/tarefa_model.dart';
import 'package:todo/pages/editar_page.dart';
import 'package:todo/repositories/favoritos_repository.dart';
import 'package:todo/repositories/tarefas_repository.dart';
import 'package:todo/services/auth_service.dart';
import 'detalhes_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TarefaMODEL> selecionadas = [];
  //

  bool? temaBar;

  @override
  Widget build(BuildContext context) {
    //
    TarefasPROVIDER tarefasRAW = Provider.of<TarefasPROVIDER>(context);
    List<TarefaMODEL> tarefas = tarefasRAW.tarefas;
    FavoritosProvider favoritasProvider =
        Provider.of<FavoritosProvider>(context);
    //

    //FUNÇÕES
    AppBar appBarDinamico() {
      return selecionadas.isEmpty
          ? AppBar(
              actions: [
                IconButton(
                    icon: const Icon(Icons.exit_to_app),
                    tooltip: 'Sair',
                    onPressed: () {
                      Provider.of<AuthService>(context, listen: false).logout();
                    }),
                IconButton(
                  icon: const Icon(Icons.add),
                  tooltip: 'Adicionar tarefa',
                  onPressed: () => Navigator.of(context).pushNamed(
                      AppRoutes.ADICIONAR_TAREFA_PAGE,
                      arguments: tarefasRAW),
                ),
              ],
              title: const Text('Tarefas'),
              centerTitle: true,
            )
          : AppBar(
              actions: [
                IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.black87,
                    ),
                    tooltip: 'Cancelar Seleção',
                    onPressed: () {
                      setState(() {
                        selecionadas = [];
                      });
                    }),
              ],
              title: Text('${selecionadas.length} Selecionados'),
              centerTitle: true,
              backgroundColor: Colors.grey[300],
              titleTextStyle:
                  const TextStyle(color: Colors.black87, fontSize: 16),
              elevation: 1,
            );
    }

    //print(temaBar);
    return Scaffold(
      appBar: appBarDinamico(),
      //
      body: tarefas.isNotEmpty
          ? ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              itemCount: tarefas.length,
              separatorBuilder: (context, i) => const Divider(),
              itemBuilder: (context, i) {
                return ListTile(
                  leading: selecionadas.contains(tarefas[i])
                      ? const CircleAvatar(child: Icon(Icons.check))
                      : GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditarPage(index: i),
                                settings: RouteSettings(arguments: tarefas[i]),
                              ),
                            );
                          },
                          child: const CircleAvatar(
                              backgroundColor: Colors.green,
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ))),
                  title: Row(
                    children: [
                      Text(
                        '${tarefas[i].nome}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      if (favoritasProvider.favoritosList.contains(tarefas[i]))
                        const Icon(Icons.star, color: Colors.amber, size: 15)
                    ],
                  ),
                  subtitle: Text(
                    '${tarefas[i].descricao}',
                    maxLines: 2,
                    overflow: TextOverflow.fade,
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      Provider.of<TarefasPROVIDER>(context, listen: false)
                          .isFeito(tarefas[i]);
                    },
                    child: tarefas[i].feito
                        ? Icon(Icons.done_all, color: Colors.green[500])
                        : const Icon(Icons.remove_done),
                  ),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DetalhesPage(tarefa: tarefas[i]))),
                  selected: selecionadas.contains(tarefas[i]),
                  selectedTileColor: Colors.blue[100],
                  onLongPress: () {
                    setState(() {
                      selecionadas.contains(tarefas[i])
                          ? selecionadas.remove(tarefas[i])
                          : selecionadas.add(tarefas[i]);
                    });
                  },
                );
              },
            )
          : const Center(child: Text('Sem tarefas :(')),
      //////
      //////
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: selecionadas.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () {
                Provider.of<FavoritosProvider>(context, listen: false)
                    .addFavoritos(selecionadas);
                selecionadas.clear();
              },
              icon: const Icon(Icons.star),
              label: const Text('FAVORITAR'),
            )
          : null,
    );
  }
}
