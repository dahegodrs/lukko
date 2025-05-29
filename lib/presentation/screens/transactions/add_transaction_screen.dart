import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../widgets/shared/custom_app_bar.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  bool _isExpense = true;
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Obtener argumentos de navegación si existen
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null && args['isExpense'] != null) {
      _isExpense = args['isExpense'] as bool;
    }

    final accentColor = _isExpense ? AppColors.lime : AppColors.teal;

    return Scaffold(
      backgroundColor: AppColors.darkGrey,
      appBar: const CustomAppBar(
        title: 'Nueva Transacción',
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Tarjeta contenedora (estilo BalanceCard)
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.darkGrey.withAlpha(204),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: accentColor.withAlpha(76),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(76),
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Selector de Tipo con iconos circulares
                    Row(
                      children: [
                        Expanded(
                          child: _buildTransactionTypeButton(
                            context: context,
                            isExpense: false,
                            icon: Icons.arrow_upward,
                            label: 'Ingreso',
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildTransactionTypeButton(
                            context: context,
                            isExpense: true,
                            icon: Icons.arrow_downward,
                            label: 'Gasto',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Campo de Cantidad
                    Text(
                      'Cantidad',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.cream.withAlpha(230),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _amountController,
                      style: TextStyle(color: AppColors.cream),
                      decoration: InputDecoration(
                        prefixText: '\$ ',
                        prefixStyle: TextStyle(color: AppColors.cream),
                        filled: true,
                        fillColor: AppColors.darkGrey.withAlpha(76),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: accentColor.withAlpha(153),
                            width: 1.5,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: accentColor.withAlpha(153),
                            width: 1.5,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.redAccent,
                            width: 1.5,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ingrese un monto';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Monto inválido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),

                    // Campo de Descripción
                    Text(
                      'Descripción',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.cream.withAlpha(230),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _descriptionController,
                      style: TextStyle(color: AppColors.cream),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.darkGrey.withAlpha(76),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: accentColor.withAlpha(153),
                            width: 1.5,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: accentColor.withAlpha(153),
                            width: 1.5,
                          ),
                        ),
                      ),
                      maxLines: 3,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ingrese una descripción';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Botón de Guardar
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'GUARDAR TRANSACCIÓN',
                  style: AppTextStyles.buttonText.copyWith(
                    color: AppColors.darkGrey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionTypeButton({
    required BuildContext context,
    required bool isExpense,
    required IconData icon,
    required String label,
  }) {
    final isSelected = _isExpense == isExpense;
    final color = isExpense ? AppColors.lime : AppColors.teal;

    return GestureDetector(
      onTap: () => setState(() => _isExpense = isExpense),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? color.withAlpha(51) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? color : AppColors.darkGrey.withAlpha(76),
            width: 1.5,
          ),
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: color.withAlpha(isSelected ? 51 : 25),
                shape: BoxShape.circle,
                border: Border.all(
                  color: color.withAlpha(isSelected ? 153 : 76),
                  width: 1.5,
                ),
              ),
              padding: const EdgeInsets.all(12),
              child: Icon(
                icon,
                color: isSelected ? color : color.withAlpha(153),
                size: 24,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? color : color.withAlpha(153),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final amount = double.parse(_amountController.text);
      final description = _descriptionController.text;

      debugPrint('''Transacción guardada:
        Tipo: ${_isExpense ? 'Gasto' : 'Ingreso'}
        Monto: \$$amount
        Descripción: $description
      ''');

      Navigator.pop(context);
    }
  }
}
