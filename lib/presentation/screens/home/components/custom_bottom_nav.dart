import 'package:flutter/material.dart';
import 'package:lukko/routes/app_router.dart';

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      selectedItemColor: const Color.fromRGBO(1, 209, 219, 1),
      unselectedItemColor: Colors.grey,
      currentIndex: 0, // Puedes parametrizar esto luego
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushNamed(context, AppRouter.home);
            break;
          case 1:
            Navigator.pushNamed(context, AppRouter.accountList);
            break;
          case 2:
            // Acción para Menú
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_balance),
          label: "Cuentas",
        ),
        BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Menú"),
      ],
    );
  }
}
