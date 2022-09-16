import 'package:prova_final/endereco.dart';
import 'package:prova_final/socio.dart';
import 'package:uuid/uuid.dart';

class Empresa {
  //para fazer: gerador de ID e data de criação
  var uuid = Uuid();
  final DateTime horarioDeCriacao = DateTime.now();
  late String razaoSocialEmpresa;
  late String nomeFantasiaEmpresa;
  late String cnpjEmpresa;
  late String telefoneEmpresa;
  late Endereco endereco;
  late Socio socio;

  Empresa(
      {required this.razaoSocialEmpresa,
      required this.nomeFantasiaEmpresa,
      required this.cnpjEmpresa,
      required this.endereco,
      required this.telefoneEmpresa,
      required this.socio});

  /*
  String toPrintEmpresas() {
    return "ID: ${uuid.v4()} \nCNPJ: $cnpjEmpresa Data Cadastro: $horarioDeCriacao \nRazão Social: $razaoSocialEmpresa \nNome Fantasia: $nomeFantasiaEmpresa \nTelefone: $telefoneEmpresa \nSócio: $socio";
  }
  */

    void toPrintEmpresa() {
    print("=================== Dados da empresa ===================\n");
    print(
        "ID: ${uuid.v4()} \nCNPJ: $cnpjEmpresa Data Cadastro: $horarioDeCriacao \nRazão Social: $razaoSocialEmpresa \nNome Fantasia: $nomeFantasiaEmpresa \nTelefone: $telefoneEmpresa \n${endereco.toPrintEndereco()}  \n=================== Dados do Sócio ===================\n${socio.toPrintSocio()}");
  }
}

