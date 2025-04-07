import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _recuperarBancoDados() async {
    final caminhoBancoDados = await getDatabasesPath();
    final localBancoDados = join(caminhoBancoDados, "banco.db");

    var bd = await openDatabase(
      localBancoDados,
      version: 1,
      onCreate: (db, dbVersaoRecente) {
        String sql =
            "CREATE TABLE usuarios (id INTEGER PRIMARY KEY AUTOINCREMENT, nome VARCHAR, idade INTEGER) ";
        db.execute(sql);
      },
    );

    //print("aberto: " + retorno.isOpen.toString());
    return bd;
  }

  _salvar() async {
    Database bd = await _recuperarBancoDados();

    Map<String, dynamic> dadosUsuario = {
      "nome": "Mauricio Santos",
      "idade": 22,
    };
    int id = await bd.insert("usuarios", dadosUsuario);
    print("Salvo: $id");
  }

  _listarDados() async{
     Database bd = await _recuperarBancoDados();

     String sql = "SELECT * FROM usuarios WHERE id = 5";

     List usuarios = await bd.rawQuery(sql);

     for (var usuario in usuarios){
      print ("item id: " + usuario ['id'].toString() + " nome" + usuario ['nome'] + " idade:" + usuario['idade'].toString());
     }
  }

  @override
  Widget build(BuildContext context) {
    _recuperarBancoDados();

    return Container();
  }
}
