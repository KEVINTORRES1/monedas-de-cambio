import 'package:flutter/material.dart';

void main() {
  runApp(const CurrencyConverterApp());
}

class CurrencyConverterApp extends StatelessWidget {
  const CurrencyConverterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Conversor de Monedas',
      theme: ThemeData.dark(),
      home: const CurrencyConverterScreen(),
    );
  }
}

class CurrencyConverterScreen extends StatefulWidget {
  const CurrencyConverterScreen({Key? key}) : super(key: key);

  @override
  State<CurrencyConverterScreen> createState() =>
      _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  final TextEditingController _controller = TextEditingController();
  String _fromCurrency = 'USD';
  String _toCurrency = 'EUR';
  double _result = 0.0;

  final Map<String, double> _rates = {
    'USD': 4200.0,
    'EUR': 4500.0,
    'MXN': 240.0,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Conversor de Monedas')),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueGrey, Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _controller,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Cantidad',
                  labelStyle: const TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white70),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: _buildCurrencyDropdown(
                      _fromCurrency,
                      (value) => setState(() => _fromCurrency = value!),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.arrow_back, color: Colors.white),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildCurrencyDropdown(
                      _toCurrency,
                      (value) => setState(() => _toCurrency = value!),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _convert,
                child: const Text('Convertir'),
              ),
              const SizedBox(height: 20),
              Text(
                'Resultado: ${_result.toStringAsFixed(2)} $_toCurrency',
                style: const TextStyle(fontSize: 24, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _convert() {
    final input = double.tryParse(_controller.text);
    if (input != null && _rates[_fromCurrency]! > 0) {
      double result = (input * _rates[_toCurrency]!) / _rates[_fromCurrency]!;
      setState(() {
        _result = result;
      });
    }
  }

  Widget _buildCurrencyDropdown(String value, ValueChanged<String?> onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white70),
      ),
      child: DropdownButton<String>(
        dropdownColor: Colors.black87,
        value: value,
        isExpanded: true,
        underline: Container(),
        style: const TextStyle(color: Colors.white),
        onChanged: onChanged,
        items:
            _rates.keys.map((String currency) {
              return DropdownMenuItem<String>(
                value: currency,
                child: Text(
                  currency,
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }).toList(),
      ),
    );
  }
}
