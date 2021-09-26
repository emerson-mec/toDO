import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/tarefa_model.dart';
import 'package:todo/repositories/tarefas_provider.dart';

class AdicionarPage extends StatefulWidget {
  const AdicionarPage({Key? key}) : super(key: key);

  @override
  State<AdicionarPage> createState() => _AdicionarPageState();
}

class _AdicionarPageState extends State<AdicionarPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController _tarefaEC = TextEditingController();
  final TextEditingController _descricaoEC = TextEditingController();
  final TextEditingController _imagemEC = TextEditingController();

  void valide() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      TarefaMODEL tarefa = TarefaMODEL(
        nome: _tarefaEC.text,
        descricao: _descricaoEC.text,
        imagem: _imagemEC.text == ''
            ? 'https://www.inovegas.com.br/site/wp-content/uploads/2017/08/sem-foto.jpg'
            : _imagemEC.text,
      );

      Provider.of<TarefasPROVIDER>(context, listen: false).adicionar(tarefa);
      //Fechar teclado.
      FocusScope.of(context).unfocus();

      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Salvo com Sucesso!!!')));
    }
  }

  bool isValidImageUrl(String url) {
    bool startWithHttp = url.toLowerCase().startsWith('http://');
    bool startWithHttps = url.toLowerCase().startsWith('https://');
    bool endstWithPng = url.toLowerCase().endsWith('.png');
    bool endstWithJpg = url.toLowerCase().endsWith('.jpg');
    bool endstWithJpeg = url.toLowerCase().endsWith('.jpeg');

    return (startWithHttp || startWithHttps) &&
        (endstWithPng || endstWithJpg || endstWithJpeg);
  }

  @override
  void dispose() {
    _tarefaEC.dispose();
    _descricaoEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nova tarefa')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _tarefaEC,
                  decoration: const InputDecoration(labelText: 'Tarefa'),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Informe o titulo da tarefa';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _descricaoEC,
                  decoration: const InputDecoration(labelText: 'Descrição'),
                ),
                //
                // LABEL IMAGEM
                //
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: TextFormField(
                        controller: _imagemEC,
                        decoration:
                            const InputDecoration(labelText: 'URL Imagem'),
                        onChanged: (value) {
                          if (isValidImageUrl(_imagemEC.text)) {
                            setState(() {});
                          }
                        },
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        height: 80,
                        width: 80,
                        child: isValidImageUrl(_imagemEC.text)
                            ? Image.network(_imagemEC.text)
                            : const Center(child: Text('Sem imagem')),
                      ),
                    ),
                  ],
                ),
                //
                //BOTÃO
                //
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () => valide(),
                      child: const Text('Salvar'),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {});
                      },
                      child: const Text('Preview'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
