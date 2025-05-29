import 'package:flutter/material.dart';
import '../../widgets/auth/auth_text_field.dart';
import '../../../core/theme/app_colors.dart';
import '../home/home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo con candado
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xB3545454), // darkGrey con 70% opacidad
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.teal, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(77),
                        blurRadius: 15,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.lock_outlined,
                    size: 40,
                    color: AppColors.cream,
                  ),
                ),
                const SizedBox(height: 24),

                // Título
                Text(
                  'LUKKO',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: AppColors.cream,
                    letterSpacing: 1.5,
                    shadows: [
                      Shadow(
                        color: Colors.black.withAlpha(51),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),

                // Formulario (estilo "vidrio esmerilado")
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: const Color(0x99545454), // darkGrey con 60% opacidad
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0x4D7B8A84), // mutedGreen 30% opacidad
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(102),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Email Field
                      AuthTextField(
                        hintText: 'Email',
                        icon: Icon(
                          Icons.email_outlined,
                          color: AppColors.cream,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Password Field
                      AuthTextField(
                        hintText: 'Password',
                        obscureText: true,
                        icon: Icon(Icons.lock_outlined, color: AppColors.cream),
                        // darkGrey 80% opacidad
                      ),
                      const SizedBox(height: 28),

                      // Sign In Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.lime,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(
                                color: const Color(
                                  0x80B7CC18,
                                ), // lime 50% opacidad
                                width: 2,
                              ),
                            ),
                            elevation: 5,
                            shadowColor: const Color(
                              0x66B7CC18,
                            ), // lime 40% opacidad
                          ),
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (_) => const HomeScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Sign Up Link
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(foregroundColor: AppColors.teal),
                  child: const Text(
                    "Don't have an account? Sign Up",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
