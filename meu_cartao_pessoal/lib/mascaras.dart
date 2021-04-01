import 'package:easy_mask/easy_mask.dart';
import 'package:meu_cartao_pessoal/extencoes.dart';

const MASCARA_TELEFONE = '(99) 9999-9999';
const MASCARA_CELULAR = '(99) 99999-9999';
const MASCARA_CNPJ = '99.999.999/9999-99';
const MASCARA_CPF = '999.999.999-99';
const CONTA_BANCARIA = '999.99999-9';
const CODIGO_BANCO = '9999';
const AGENCIA = '9999';
const OPERACAO = '999';

final maskTel = TextInputMask(mask: [MASCARA_TELEFONE], reverse: false);
final maskCel = TextInputMask(mask: [MASCARA_CELULAR], reverse: false);
final maskTelCel =
    TextInputMask(mask: [MASCARA_TELEFONE, MASCARA_CELULAR], reverse: false);
final maskCnpj = TextInputMask(mask: [MASCARA_CNPJ], reverse: false);
final maskCpf = TextInputMask(mask: [MASCARA_CPF], reverse: false);
final maskCpfCnpj =
    TextInputMask(mask: [MASCARA_CPF, MASCARA_CNPJ], reverse: false);
final maskContaBancaria = TextInputMask(mask: [CONTA_BANCARIA], reverse: false);
final maskAgencia = TextInputMask(mask: [AGENCIA], reverse: false);
final maskOperacao = TextInputMask(mask: [OPERACAO], reverse: false);
final maskCodigoBanco = TextInputMask(mask: [CODIGO_BANCO], reverse: false);

abstract class UtilsMask {
  static String maskTelCel(String value) {
    String _value = value.somenteNumeros();
    MagicMask mask;

    if (_value.isNotEmpty) {
      if (_value.length == 11) {
        mask = MagicMask.buildMask(MASCARA_CELULAR);
      } else {
        mask = MagicMask.buildMask(MASCARA_TELEFONE);
      }

      return mask.getMaskedString(_value);
    }

    return value;
  }

  static String maskCpfCnpj(String value) {
    String _value = value.somenteNumeros();
    MagicMask mask;

    if (_value.isNotEmpty) {
      if (_value.length == 14) {
        mask = MagicMask.buildMask(MASCARA_CNPJ);
      } else {
        mask = MagicMask.buildMask(MASCARA_CPF);
      }

      return mask.getMaskedString(_value);
    }

    return value;
  }

  static String maskContaBancaria(String value) {
    String _value = value.somenteNumeros();
    MagicMask mask;

    if (_value.isNotEmpty) {
      if (_value.length == 9) {
        mask = MagicMask.buildMask(CONTA_BANCARIA);
      }
      return mask.getMaskedString(_value);
    }

    return value;
  }
}

extension MaskExtension on String {
  String maskTelefone() {
    String _value = this.somenteNumeros();

    if (_value.isNotEmpty) {
      MagicMask mask = MagicMask.buildMask(MASCARA_TELEFONE);
      return mask.getMaskedString(_value);
    }

    return this;
  }

  String maskCelular() {
    String _value = this.somenteNumeros();

    if (_value.isNotEmpty) {
      MagicMask mask = MagicMask.buildMask(MASCARA_CELULAR);
      return mask.getMaskedString(_value);
    }

    return this;
  }

  String maskTelCel() {
    String _value = this.somenteNumeros();

    if (_value.isNotEmpty) {
      MagicMask mask;

      if (_value.length == 11) {
        mask = MagicMask.buildMask(MASCARA_CELULAR);
      } else {
        mask = MagicMask.buildMask(MASCARA_TELEFONE);
      }

      return mask.getMaskedString(_value);
    }

    return this;
  }

  String maskCpfCnpj() {
    String _value = this.somenteNumeros();
    MagicMask mask;

    if (_value.isNotEmpty) {
      if (_value.length == 14) {
        mask = MagicMask.buildMask(MASCARA_CNPJ);
      } else {
        mask = MagicMask.buildMask(MASCARA_CPF);
      }

      return mask.getMaskedString(_value);
    }

    return this;
  }

  String maskContaBancaria() {
    String _value = this.somenteNumeros();
    MagicMask mask;

    if (_value.isNotEmpty) {
      if (_value.length == 9) {
        mask = MagicMask.buildMask(CONTA_BANCARIA);
      }
      return mask.getMaskedString(_value);
    }

    return this;
  }
}
