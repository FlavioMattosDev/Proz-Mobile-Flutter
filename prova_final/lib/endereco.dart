//Criação do Objeto Endereço:
class Endereco {
  String logradouro = "";
  String numero = "";
  String complemento = "";
  String bairro = "";
  String cidade = "";
  String estado = "";
  String cep = "";

//Método construtor do Endereço:
  Endereco(
    {required this.logradouro,
    required this.numero,
    required this.complemento,
    required this.bairro,
    required this.cidade,
    required this.estado,
    required this.cep});

  
  String toPrintEndereco() {
    return "$logradouro, $numero, $complemento,$bairro, $cidade/$estado, $cep";
  }
}
