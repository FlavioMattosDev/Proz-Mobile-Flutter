import 'package:prova_final/endereco.dart';

class Socio {
  late String nomeSocio;
  late String cpfSocio;
  late Endereco endereco;

  Socio(
      {required this.nomeSocio,
      required this.cpfSocio,
      required this.endereco});

  
  String toPrintSocio() {
    return "Nome: $nomeSocio \nCPF: $cpfSocio \nEndereço: \n${endereco.toPrintEndereco()}";
  }

}
