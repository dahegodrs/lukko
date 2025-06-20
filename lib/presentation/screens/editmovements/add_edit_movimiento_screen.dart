import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lukko/core/theme/app_colors.dart';
import 'package:lukko/domain/entities/movimiento.dart';
import 'package:lukko/presentation/blocs/cuentas_provider.dart';

class AddOrEditMovimientoScreen extends StatefulWidget {
  final int? cuentaIndex;
  final Movimiento? movimiento;
  final int? movimientoIndex;

  const AddOrEditMovimientoScreen({
    super.key,
    this.cuentaIndex,
    this.movimiento,
    this.movimientoIndex,
  });

  @override
  State<AddOrEditMovimientoScreen> createState() =>
      _AddOrEditMovimientoScreenState();
}

class _AddOrEditMovimientoScreenState extends State<AddOrEditMovimientoScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _tipo;
  late String _titulo;
  late String _descripcion;
  late String _categoria;
  late int _valor;
  int? _cuentaSeleccionada;

  final List<String> _categorias = [
    "Alimentos",
    "Ropa",
    "Pensión",
    "Universidad",
    "Otros",
  ];

  @override
  void initState() {
    super.initState();
    final movimiento = widget.movimiento;
    _tipo = movimiento?.tipo ?? 'gasto';
    _titulo = movimiento?.titulo ?? '';
    _descripcion = movimiento?.descripcion ?? '';
    _categoria = movimiento?.categoria ?? _categorias.first;
    _valor = movimiento?.valor ?? 0;
    _cuentaSeleccionada = widget.cuentaIndex;
  }

  void _guardarMovimiento() {
    if (_formKey.currentState!.validate() && _cuentaSeleccionada != null) {
      _formKey.currentState!.save();
      final movimiento = Movimiento(
        titulo: _titulo,
        descripcion: _descripcion,
        categoria: _categoria,
        valor: _valor,
        tipo: _tipo,
      );

      final provider = Provider.of<CuentasProvider>(context, listen: false);

      if (widget.movimiento != null && widget.movimientoIndex != null) {
        provider.editarMovimiento(
          indexCuenta: _cuentaSeleccionada!,
          indexMovimiento: widget.movimientoIndex!,
          nuevoMovimiento: movimiento,
        );
      } else {
        provider.agregarMovimiento(_cuentaSeleccionada!, movimiento);
      }

      provider.recalcularTotales(_cuentaSeleccionada!);

      Navigator.pop(context);
    }
  }

  Widget _buildDropdown<T>({
    required T value,
    required List<DropdownMenuItem<T>> items,
    required void Function(T?) onChanged,
    required String label,
  }) {
    return DropdownButtonFormField<T>(
      value: value,
      items: items,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          color: AppColors.darkGrey,
          fontWeight: FontWeight.w500,
        ),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade700, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.lime, width: 2),
        ),
      ),
      dropdownColor: Colors.white,
      style: const TextStyle(
        color: AppColors.darkGrey,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      iconEnabledColor: AppColors.darkGrey,
    );
  }

  Widget _buildTextField(
    String initialValue,
    String label,
    String? hint,
    Function(String) onSaved, {
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      initialValue: initialValue,
      keyboardType: keyboardType,
      onSaved: (val) => onSaved(val!),
      validator: validator,
      style: const TextStyle(color: AppColors.darkGrey),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.black45),
        labelStyle: const TextStyle(color: AppColors.darkGrey),
        filled: true,
        fillColor: Colors.white,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final cuentas = Provider.of<CuentasProvider>(context).cuentas;

    return Scaffold(
      backgroundColor: AppColors.darkGrey,
      appBar: AppBar(
        title: Text(
          widget.movimiento != null ? 'Editar Movimiento' : 'Nuevo Movimiento',
        ),
        backgroundColor: AppColors.darkGrey,
        foregroundColor: Colors.white,
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
                      _buildDropdown<String>(
                        value: _tipo,
                        items: ['ingreso', 'gasto']
                            .map(
                              (tipo) => DropdownMenuItem(
                                value: tipo,
                                child: Text(
                                  tipo[0].toUpperCase() + tipo.substring(1),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) => setState(() => _tipo = value!),
                        label: 'Tipo de movimiento',
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        _titulo,
                        'Título',
                        'Ingrese el título del movimiento',
                        (val) => _titulo = val,
                        validator: (val) => val == null || val.isEmpty
                            ? 'Ingrese un título'
                            : null,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        _descripcion,
                        'Descripción',
                        'Descripción del movimiento (opcional)',
                        (val) => _descripcion = val,
                      ),
                      const SizedBox(height: 16),
                      _buildDropdown<String>(
                        value: _categoria,
                        items: _categorias
                            .map(
                              (cat) => DropdownMenuItem(
                                value: cat,
                                child: Text(cat),
                              ),
                            )
                            .toList(),
                        onChanged: (val) => setState(() => _categoria = val!),
                        label: 'Categoría',
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        _valor != 0 ? _valor.toString() : '',
                        'Valor',
                        'Ej: 20000',
                        (val) => _valor = int.tryParse(val) ?? 0,
                        keyboardType: TextInputType.number,
                        validator: (val) => val == null || val.isEmpty
                            ? 'Ingrese un valor'
                            : null,
                      ),
                      const SizedBox(height: 16),
                      _buildDropdown<int>(
                        value: _cuentaSeleccionada!,
                        items: List.generate(
                          cuentas.length,
                          (index) => DropdownMenuItem(
                            value: index,
                            child: Text(cuentas[index].nombre),
                          ),
                        ),
                        onChanged: (val) =>
                            setState(() => _cuentaSeleccionada = val!),
                        label: 'Cuenta',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.lightcoral,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      "Cancelar",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _guardarMovimiento,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.aguamarina,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      widget.movimiento != null ? 'Actualizar' : 'Guardar',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
