import 'dart:io';
import 'package:prova_final/empresa.dart';
import 'package:prova_final/endereco.dart';
import 'package:prova_final/socio.dart';

void main() {
  limparConsole();
  List<Empresa> listaEmpresas = [];

  printCadastroInicial();

  bool loop = true;

  do {
    print(
        '----------\nEscolha uma função: \n [1] Cadastrar uma nova empresa \n [2] Buscar Empresa cadastrada por CNPJ \n [3] Buscar Empresa por CPF do Sócio \n [4] Listar Empresas cadastradas em ordem alfabética (baseado na Razão Social) \n [5] Excluir uma empresa (por ID) \n [0] Fechar o programa');

    int menu = int.parse(stdin.readLineSync()!);

    switch (menu) {
      // Case 01 Cadastrar uma nova empresa
      case 1:
        limparConsole();
        Empresa novaEmpresa = cadastrarEmpresa();
        listaEmpresas.add(novaEmpresa);
        for (var element in listaEmpresas) {
          element.toPrintEmpresa();
        }
        break;
      // Case 02 Buscar Empresa cadastrada por CNPJ
      case 2:
        limparConsole();
        print(
            'Digite o CNPJ da empresa que deseja buscar.(apenas números, 14 dígitos)');
        String inputCnpjEmpresa = stdin.readLineSync()!;
        String cnpjFormatado = "";
        cnpjFormatado = formatarCnpj(inputCnpjEmpresa);
        print(buscarEmpresaCnpj(listaEmpresas, cnpjFormatado));
        break;
      // Case 03 Buscar Empresa por CPF do Sócio
      case 3:
        limparConsole();
        print(
            'Digite o CPF do sócio da empresa que deseja buscar.(apenas números, 11 dígitos)');
        String cpfSocio = stdin.readLineSync()!;
        String cpfFormatado = "";
        cpfFormatado = formatarCpf(cpfSocio);
        print(buscarSocioCpf(listaEmpresas, cpfFormatado));
        break;
      // Case 04 Listar Empresas cadastradas em ordem alfabética
      case 4:
        print(organizarAlfabeticamente(listaEmpresas));
        limparConsole();
        break;
      // Case 05 Excluir uma empresa
      case 5:
        limparConsole();
        String uuid = stdin.readLineSync()!;
        print(excluirEmpresaId(uuid, listaEmpresas));
        break;
      // Case 00 ============================
      case 0:
        limparConsole();
        print('Encerrando o programa, volte sempre!');
        loop = false;
        break;
      // Case Default =======================
      default:
        limparConsole();
        print('A opção digitada é inválida, tente novamente!');
        break;
    }
  } while (loop);
}

// ----------------- FUNÇÕES ---------------------------------
// Limpar o console:
void limparConsole() => print("\x1B[2J\x1B[0;0H");

// Função de boas vindas cadastro de empresas:
void printCadastroInicial() {
  print("Olá! Seja bem-vindo aplicativo de Registro de Empresas.");
  print(
      "Comece adicionando todos os dados da empresa solicitados. Ou se desejar, escolha outra opção");
  print("Iniciando... \n-----==============================-----");
}

//Função para cadastrar Empresa:
Empresa cadastrarEmpresa() {
  print('Digite a Razão Social da Empresa.');
  String inputRazaoSocialEmpresa = stdin.readLineSync()!;

  print('Digite o Nome Fantasia da Empresa.');
  String inputNomeFantasiaEmpresa = stdin.readLineSync()!;

  print('Digite o CNPJ da Empresa (apenas números, 14 dígitos).');
  String inputCnpjEmpresa = stdin.readLineSync()!;
  if (inputCnpjEmpresa.length != 14) {
    print('CNPJ inválido. Digite corretamente.');
  }
  inputCnpjEmpresa = formatarCnpj(inputCnpjEmpresa);

  print('Digite o Telefone da Empresa (apenas números).');
  String inputTelefoneEmpresa = stdin.readLineSync()!;

  Endereco inputEnderecoEmpresa = cadastrarEnderecoEmpresa();

  print('=======================================');
  print('Será necessário associar um sócio a empresa.');
  print('Faça o cadastro do Sócio:');
  Socio socio = cadastrarSocio();

  return Empresa(
      razaoSocialEmpresa: inputRazaoSocialEmpresa,
      nomeFantasiaEmpresa: inputNomeFantasiaEmpresa,
      cnpjEmpresa: inputCnpjEmpresa,
      endereco: inputEnderecoEmpresa,
      telefoneEmpresa: inputTelefoneEmpresa,
      socio: socio);
}

// Função para cadastrar Endereço da empresa:
Endereco cadastrarEnderecoEmpresa() {
  print('Digite o endereço da rua da Empresa.');
  String logradouroEmpresa = stdin.readLineSync()!;
  print('Digite o número de endereço da Empresa.');
  String numeroEmpresa = stdin.readLineSync()!;
  print('Digite o complemento de endereço da Empresa.');
  String complementoEmpresa = stdin.readLineSync()!;
  print('Digite o bairro da Empresa.');
  String bairroEmpresa = stdin.readLineSync()!;
  print('Digite a cidade da Empresa.');
  String cidadeEmpresa = stdin.readLineSync()!;
  print('Digite o estado da Empresa.');
  String estadoEmpresa = stdin.readLineSync()!;
  print('Digite o CEP da Empresa.');
  String cepEmpresa = stdin.readLineSync()!;
  return Endereco(
      logradouro: logradouroEmpresa,
      numero: numeroEmpresa,
      complemento: complementoEmpresa,
      bairro: bairroEmpresa,
      cidade: cidadeEmpresa,
      estado: estadoEmpresa,
      cep: cepEmpresa);
}

// Função de cadastrar o sócio
Socio cadastrarSocio() {
  print('Digite o nome do Sócio.');
  String nomeSocio = stdin.readLineSync()!;
  print('Digite o CPF do sócio(apenas números, 11 dígitos).');
  String cpfSocio = stdin.readLineSync()!;
  if (cpfSocio.length != 11) {
    print('CPF inválido. Digite corretamente.');
  }
  cpfSocio = formatarCpf(cpfSocio);
  print('Faça o cadastro do endereço do sócio:');
  Endereco enderecoSocio = cadastrarEnderecoSocio();
  return Socio(
      nomeSocio: nomeSocio, cpfSocio: cpfSocio, endereco: enderecoSocio);
}

// Função para cadastrar Endereço do Sócio:
Endereco cadastrarEnderecoSocio() {
  print('Digite o endereço da Sócio.');
  String logradouroSocio = stdin.readLineSync()!;
  print('Digite o número de endereço do Sócio.');
  String numeroSocio = stdin.readLineSync()!;
  print('Digite o complemento do endereço do Sócio.');
  String complementoSocio = stdin.readLineSync()!;
  print('Digite o bairro do Sócio.');
  String bairroSocio = stdin.readLineSync()!;
  print('Digite a cidade do Sócio.');
  String cidadeSocio = stdin.readLineSync()!;
  print('Digite o estado do Sócio.');
  String estadoSocio = stdin.readLineSync()!;
  print('Digite o CEP do Sócio.');
  String cepSocio = stdin.readLineSync()!;
  return Endereco(
      logradouro: logradouroSocio,
      numero: numeroSocio,
      complemento: complementoSocio,
      bairro: bairroSocio,
      cidade: cidadeSocio,
      estado: estadoSocio,
      cep: cepSocio);
}

//Função para formatar o Cpf do sócio:
String formatarCpf(String cpfSocio) {
  String cpfFormatado = "";
  cpfFormatado +=
      "${cpfSocio.substring(0, 3)}.${cpfSocio.substring(3, 6)}.${cpfSocio.substring(6, 9)}-${cpfSocio.substring(9, 11)}";
  return cpfFormatado;
}

//Função para formatar o Cpnj da Empresa:
String formatarCnpj(String inputCnpjEmpresa) {
  String cnpjFormatado = "";
  cnpjFormatado +=
      "${inputCnpjEmpresa.substring(0, 2)}.${inputCnpjEmpresa.substring(2, 5)}.${inputCnpjEmpresa.substring(5, 8)}/${inputCnpjEmpresa.substring(8, 12)}-${inputCnpjEmpresa.substring(12, 14)}";
  return cnpjFormatado;
}

//Função para buscar a empresa pelo Cnpj:
Empresa? buscarEmpresaCnpj(
    List<Empresa> listaEmpresas, String inputCnpjEmpresa) {
  if (listaEmpresas.isEmpty) {
    print('Nenhuma empresa cadastrada');
    return null;
  }
  for (var empresa in listaEmpresas) {
    if (empresa.cnpjEmpresa == inputCnpjEmpresa) {
      return empresa;
    }
  }
  return null;
}

//Função para buscar o sócio pelo Cpf:
Empresa? buscarSocioCpf(List<Empresa> listaEmpresas, String cpfSocio) {
  if (listaEmpresas.isEmpty) {
    print('Nenhum sócio cadastrado');
    return null;
  }
  for (var empresa in listaEmpresas) {
    if (empresa.socio.cpfSocio == cpfSocio) {
      return empresa;
    }
  }
  return null;
}

//Função para organizar alfabeticamente as empresas:
String organizarAlfabeticamente(List<Empresa> listaEmpresas) {
  if (listaEmpresas.isEmpty) {
    return 'Nenhuma empresa cadastrada';
  }
  listaEmpresas
      .sort((a, b) => a.razaoSocialEmpresa.compareTo(b.razaoSocialEmpresa));
  print(listaEmpresas);
  return 'Essa é sua lista de empresas em ordem alfabética!';
}

//FUNÇÃO PARA EXCLUIR EMPRESA POR ID:
String excluirEmpresaId(String uuid, List<Empresa> listaEmpresas) {
  if (listaEmpresas.isEmpty) {
    return 'Nenhuma empresa cadastrada';
  }
  Empresa? excluirEmpresa;

  for (var empresa in listaEmpresas) {
    if (empresa.uuid == uuid) {
      excluirEmpresa = empresa;
    }
  }

  if (excluirEmpresa == null) {
    return 'Digite um ID válido.';
  }

  listaEmpresas.removeWhere((empresa) => empresa.uuid == uuid);
  return 'Empresa removida com sucesso!';
}
