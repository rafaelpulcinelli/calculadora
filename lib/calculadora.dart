import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  String _expressao = '';
  String _resultado = '';

  void _pressionarBotao(String valor) {
    setState(() {
      if (valor == 'C') {
        _expressao = '';
        _resultado = '';
      } else if (valor == '=') {
        _calcularResultado();
      } else if (valor == '⌫') { // Botão de backspace
        if (_expressao.isNotEmpty) {
          _expressao = _expressao.substring(0, _expressao.length - 1);
        }
      } else {
        _expressao += valor;
      }
    });
  }

  void _calcularResultado() {
    try {
      _resultado = _avaliarExpressao(_expressao).toString();
    } catch (e) {
      _resultado = 'Erro';
    }
  }

  double _avaliarExpressao(String expressao) {
    expressao = expressao.replaceAll('x', '*');
    expressao = expressao.replaceAll('÷', '/');
    ExpressionEvaluator avaliador = const ExpressionEvaluator();
    return avaliador.eval(Expression.parse(expressao), {});
  }

  Widget _botao(String texto, {Color cor = Colors.green}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: cor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: () => _pressionarBotao(texto),
      child: Text(
        texto,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black, width: 1),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                _expressao,
                style: const TextStyle(fontSize: 24),
                textAlign: TextAlign.right,
              ),
            ),
          ),
          const Divider(color: Colors.black),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                _resultado,
                style:
                    const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                textAlign: TextAlign.right,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            flex: 8,
            child: GridView.count(
              crossAxisCount: 4,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              children: [
                _botao('7'),
                _botao('8'),
                _botao('9'),
                _botao('÷', cor: Colors.orange),
                _botao('4'),
                _botao('5'),
                _botao('6'),
                _botao('x', cor: Colors.orange),
                _botao('1'),
                _botao('2'),
                _botao('3'),
                _botao('-', cor: Colors.orange),
                _botao('0'),
                _botao('.'),
                _botao('=', cor:Colors.blue),
                _botao('+', cor: Colors.orange),
                _botao('C', cor: Colors.red),
                _botao('('),
                _botao(')'),
                _botao('⌫', cor: const Color.fromARGB(149, 244, 67, 54)), // Botão de backspace
              ],
            ),
          ),
        ],
      ),
    );
  }
}