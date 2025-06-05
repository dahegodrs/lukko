import 'package:flutter/material.dart';
import 'package:lukko/core/theme/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:lukko/domain/entities/cuenta.dart';
import 'package:lukko/presentation/blocs/cuentas_provider.dart';

class NewAccountScreen extends StatefulWidget {
  const NewAccountScreen({super.key});

  @override
  State<NewAccountScreen> createState() => _NewAccountScreenState();
}

class _NewAccountScreenState extends State<NewAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _cupoController = TextEditingController();
  final _deudaController = TextEditingController();

  String _selectedRed = 'Visa';
  final List<String> _redesPago = [
    'Visa',
    'Mastercard',
    'Amex',
    'Diners Club',
    'Maestro',
    'Discover',
  ];

  void _guardarCuenta() {
    if (_formKey.currentState!.validate()) {
      final nuevaCuenta = Cuenta(
        nombre: _nombreController.text,
        cupo: int.tryParse(_cupoController.text) ?? 0,
        deuda: int.tryParse(_deudaController.text) ?? 0,
        red: _selectedRed,
      );

      Provider.of<CuentasProvider>(
        context,
        listen: false,
      ).agregarCuenta(nuevaCuenta);

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkGrey,
      appBar: AppBar(
        title: const Text("Nueva cuenta"),
        backgroundColor: AppColors.darkGrey,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _buildTextField(
                        _nombreController,
                        'Nombre',
                        'Ingrese el nombre de la cuenta',
                        textColor: AppColors.darkGrey,
                        hintColor: Colors.black45,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        _cupoController,
                        'Cupo total',
                        'Ej: 3000000',
                        keyboardType: TextInputType.number,
                        textColor: AppColors.darkGrey,
                        hintColor: Colors.black45,
                      ),
                      const SizedBox(height: 16),
                      _buildDropdown(
                        dropdownTextColor: AppColors.darkGrey,
                        dropdownFillColor: Colors.white,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        _deudaController,
                        'Deuda actual',
                        'Ej: 500000',
                        keyboardType: TextInputType.number,
                        textColor: AppColors.darkGrey,
                        hintColor: AppColors.darkGrey,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildButton(
                    "Cancelar",
                    AppColors.lightcoral,
                    () => Navigator.pop(context),
                  ),
                  _buildButton("Guardar", AppColors.aguamarina, _guardarCuenta),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavWithAdd(currentIndex: 1),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    String hint, {
    TextInputType keyboardType = TextInputType.text,
    Color textColor = Colors.white,
    Color hintColor = Colors.white38,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: TextStyle(color: textColor),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        hintStyle: TextStyle(color: hintColor),
        labelStyle: TextStyle(color: textColor),
        filled: true,
        fillColor: Colors.white, // Fondo blanco para que contraste con el borde
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
      ),
      validator: (value) =>
          value == null || value.isEmpty ? 'Este campo es obligatorio' : null,
    );
  }

  Widget _buildDropdown({
    Color dropdownTextColor = AppColors.darkGrey,
    Color dropdownFillColor = Colors.white,
  }) {
    return DropdownButtonFormField<String>(
      value: _selectedRed,
      decoration: InputDecoration(
        labelText: 'Red de pago',
        labelStyle: TextStyle(
          color: dropdownTextColor,
          fontWeight: FontWeight.w500,
        ),
        filled: true,
        fillColor: dropdownFillColor,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade700, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.lime, width: 2),
        ),
      ),
      dropdownColor: Colors.white, // fondo del menú desplegable
      style: TextStyle(
        color: AppColors.darkGrey, // color del texto seleccionado
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      iconEnabledColor: AppColors.darkGrey, // color del ícono desplegable
      items: _redesPago.map((red) {
        return DropdownMenuItem<String>(
          value: red,
          child: Text(
            red,
            style: TextStyle(
              color: AppColors.darkGrey,
            ), // color de texto en el menú
          ),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedRed = value!;
        });
      },
    );
  }

  Widget _buildButton(String text, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}

class CustomBottomNavWithAdd extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavWithAdd({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      backgroundColor: Colors.white,
      selectedItemColor: const Color.fromRGBO(1, 209, 219, 1),
      unselectedItemColor: Colors.grey,
      onTap: (index) {
        if (index == currentIndex) return;

        switch (index) {
          case 0:
            Navigator.pushReplacementNamed(context, '/home');
            break;
          case 1:
            // Ya estás en "Agregar", no hacer nada
            break;
          case 2:
            Navigator.pushReplacementNamed(context, '/menu');
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
        BottomNavigationBarItem(icon: Icon(Icons.add), label: "Agregar"),
        BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Menú"),
      ],
    );
  }
}
